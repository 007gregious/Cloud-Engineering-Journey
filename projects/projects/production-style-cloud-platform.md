
# Production Style Cloud Platform Project

## Table of Contents

- [Architecture Overview](#architecture-overview)

- [ECS vs EC2 — Why ECS?](#ecs-vs-ec2--why-ecs)

- [Why Private Subnet Matters](#why-private-subnet-matters)

- [Why Terraform Was Used](#why-terraform-was-used)

- [Security Considerations](#security-considerations)

- [Scalability Considerations](#scalability-considerations)

- [Failure Handling](#failure-handling)

- [Tradeoffs Considered](#tradeoffs-considered)

---

## Architecture Overview

This project deploys a Dockerized **nginx application** on AWS using a fully automated CI/CD pipeline. Code pushed to GitHub triggers a GitHub Actions workflow that builds and pushes a Docker image to Amazon ECR, while Terraform provisions and manages all underlying AWS infrastructure.

```makefile
Developer → GitHub Repo → GitHub Actions → Amazon ECR
                     ↓
                 Terraform
                     ↓
         ┌─────── Custom VPC ────────┐
         │  Public Subnet            │
         │  ┌─────────────────────┐  │
         │  │ Internet Gateway    │  │
         │  │ Load Balancer (ALB) │  │
         │  │ Bastion Host        │  │
         │  └─────────────────────┘  │
         │  Private Subnet           │
         │  ┌─────────────────────┐  │
         │  │ ECS (nginx app)     │  │
         │  │ Security Group      │  │
         │  └─────────────────────┘  │
         └───────────────────────────┘
                     ↓
         IAM Role · CloudWatch
```

![AWS Production Style cloud Platform Diagram](/diagrams/production-style-cloud-platform/production-style-cloud-platform.drawio.png)

---

## ECS vs EC2 — Why ECS?

**Choice: Amazon ECS (Elastic Container Service)**  

The application is packaged as a Docker container, which makes ECS the natural fit over a raw EC2 instance.

| Factor | ECS | EC2 |
| --- | --- | --- |
| Deployment unit | Docker image | AMI / bash scripts |
| Scaling | Task-level auto-scaling | Instance-level scaling |
| Operational overhead | Low — AWS manages the scheduler | Higher — you manage the OS |
| CI/CD integration | Pull new image → redeploy task | SSH in or use CodeDeploy |
| Cost model | Pay per task (Fargate) or per cluster (EC2 launch type) | Pay per instance (always on) |

**Key reasons for ECS in this architecture:**

- **Containerised workload** — the nginx app is already Dockerized, so ECS is the direct runtime for it rather than running Docker manually on EC2.

- **Simpler deployments** — GitHub Actions pushes a new image to ECR; ECS picks it up and replaces the running task with zero manual SSH access needed.

- **Easier scaling** — traffic spikes are handled by scaling ECS tasks horizontally, not by resizing EC2 instances.

- **Less patching** — with Fargate launch type, there is no underlying EC2 OS to patch or maintain.

> **When EC2 would be the better choice:** workloads that need persistent local storage, require specific kernel configurations, or run software that cannot be containerised.

---

## Why Private Subnet Matters

**The application runs in the private subnet — it is never directly reachable from the internet.**

The VPC is split into two tiers:

```makefile
Internet
    │
    ▼
Internet Gateway
    │
    ▼
Public Subnet  ──────────────────────────────
│  ALB (Load Balancer)   Bastion Host       │
─────────────────────────────────────────────
    │                         │
    │ (filtered traffic)      │ (SSH only)
    ▼                         ▼
Private Subnet ──────────────────────────────
│           ECS — nginx app                 │
─────────────────────────────────────────────
```

**Why this matters:**

- **Reduced attack surface** — the ECS tasks have no public IP. An attacker cannot reach them directly even if they know the IP range. All traffic must pass through the ALB first.

- **ALB as the single entry point** — the Application Load Balancer sits in the public subnet and only forwards traffic that matches its listener rules (port 80/443). Everything else is dropped before it reaches the app.

- **Bastion Host for admin access** — SSH into the private subnet is only possible via the Bastion Host (a jump server in the public subnet), and only from a whitelisted IP. There is no direct SSH path from the internet to the app.

- **Compliance alignment** — most security standards (PCI DSS, SOC 2, ISO 27001) require that application servers not be directly internet-accessible. Private subnets satisfy this requirement by design.

---

## Why Terraform Was Used

**Choice: Terraform (Infrastructure as Code)**  

All AWS resources — VPC, subnets, security groups, IAM roles, ECS cluster, ALB, CloudWatch log groups — are defined in Terraform configuration files stored alongside the application code in the GitHub repository.

**Reasons for choosing Terraform over manual console setup or AWS CloudFormation:**

1. **Reproducibility** — the same Terraform configuration can spin up an identical environment in any AWS region or account. There is no "it works on my AWS account" problem.

2. **Version control** — infrastructure changes go through the same Git workflow as code changes: pull request, review, merge. Every change is auditable.

3. **Automated provisioning via CI/CD** — GitHub Actions runs `terraform apply` as part of the pipeline. A merged PR can provision or update infrastructure without any human clicking in the AWS console.

4. **State management** — Terraform tracks the current state of all resources. It knows what exists, what needs to change, and what needs to be destroyed. This prevents configuration drift.

5. **Modularity** — VPC, compute, security, and monitoring concerns are separated into modules, making the configuration readable and reusable.

6. **Multi-provider support** — unlike CloudFormation (AWS-only), Terraform can manage resources across AWS, GitHub, Datadog, and other providers in the same workflow.

**Terraform resources provisioned in this architecture:**

- `aws_vpc` — Custom VPC with DNS support enabled

- `aws_subnet` — Public and private subnets across availability zones

- `aws_internet_gateway` — Attached to the VPC for public internet access

- `aws_security_group` — Rules for ALB, ECS tasks, and Bastion Host

- `aws_iam_role` — EC2/ECS task execution role with ECR and CloudWatch permissions

- `aws_ecs_cluster` / `aws_ecs_task_definition` / `aws_ecs_service` — Container orchestration

- `aws_lb` / `aws_lb_listener` / `aws_lb_target_group` — Application Load Balancer

- `aws_cloudwatch_log_group` — Log destination for ECS task stdout/stderr

---

## Security Considerations

Security is applied in layers across the architecture. No single control is relied upon exclusively.

### 1. Network Layer — Security Groups

- **ALB Security Group**: allows inbound `TCP 443` (HTTPS) and `TCP 80` (HTTP redirect) from `0.0.0.0/0`. No other ports open.

- **ECS Task Security Group**: allows inbound traffic only from the ALB security group ID — not from any CIDR range. Even traffic from within the VPC is blocked unless it comes through the ALB.

- **Bastion Security Group**: allows inbound `TCP 22` only from a specific admin IP address. Access is revoked by removing the rule — no credentials to rotate.

- All security groups **deny everything by default**. Rules are allow-list only.

### 2. Identity & Access — IAM Role

The ECS task runs with a least-privilege IAM Role that grants only what is needed:

```bash
ecr:GetAuthorizationToken
ecr:BatchGetImage
ecr:GetDownloadUrlForLayer
logs:CreateLogStream
logs:PutLogEvents
```

No `*` actions. No `AdministratorAccess`. The role cannot create other roles, access S3, or call any service outside its defined scope.

### 3. No Direct Internet Exposure

- ECS tasks run in the **private subnet** with no public IP assigned.

- Outbound internet access from the private subnet is routed through a **NAT Gateway** (in the public subnet), so tasks can pull images and send logs without being reachable inbound.

- The Bastion Host is the **only SSH entry point** and is itself hardened (no password auth, key-pair only).

### 4. Secrets Management

- Docker image tags and environment variables are passed to ECS tasks via **AWS Systems Manager Parameter Store** or **Secrets Manager** — never hardcoded in the task definition or in the GitHub repository.

- GitHub Actions uses **OIDC authentication** with AWS (not long-lived access keys) to assume a deploy role scoped to ECR push and ECS update permissions only.

### 5. Observability — CloudWatch

- ECS task logs (stdout/stderr from nginx) are streamed to a **CloudWatch Log Group**.

- **CloudWatch Alarms** are configured on CPU utilisation, memory utilisation, and ALB 5xx error rate.

- Alarms trigger **SNS notifications** to the on-call channel.

- Visibility into the running system means anomalies (unexpected traffic spikes, repeated errors) are caught before they become incidents.

### 6. Image Security

- Docker images are built from a **minimal base image** (e.g. `nginx:alpine`).

- The GitHub Actions pipeline runs a vulnerability scan (e.g. Trivy or AWS Inspector) against the image before pushing to ECR.

- ECR has **image scanning on push** enabled. Images with critical CVEs are flagged before deployment.

## Scalability Considerations

- ECS/Kubernetes can scale containers horizontally

- Infrastructure can be recreated consistently using Terraform

- Load balancing improves traffic distribution

- Monitoring supports proactive scaling decisions

## Failure Handling

**Potential failure scenarios considered:**

- EC2/container crash

- High CPU utilization

- Misconfigured security groups

- Failed deployments

**Mitigation strategies include:**

- CloudWatch alarms

- Auto-recovery mechanisms

- Infrastructure as Code

- Container orchestration

## Tradeoffs Considered

- ECS chosen for simplicity over Kubernetes complexity

- Terraform used for reproducibility

- Bastion host improves security but adds operational overhead

---
