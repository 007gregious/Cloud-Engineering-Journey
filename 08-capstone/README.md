# Capstone Project — Full AWS Deployment Pipeline

> End-to-end automated deployment: GitHub → Docker → ECR → ECS Fargate → CloudWatch

---

## Architecture

```makefile
Developer pushes code
↓
GitHub Actions triggers
↓
Trivy scans image for vulnerabilities
↓
Docker image built + pushed to Amazon ECR
↓
ECS Fargate pulls new image
↓
nginx app live behind ALB
↓
CloudWatch logs + alarms monitoring
```

---

## What's Inside

```makefile
08-capstone/
├── app/
│   ├── Dockerfile          # Minimal nginx:alpine image
│   ├── index.html          # Custom app page
│   └── nginx.conf          # Health check + security headers
├── terraform/
│   ├── main.tf             # Provider config
│   ├── ecr.tf              # ECR repo, lifecycle policy, GitHub OIDC role
│   ├── variables.tf        # Input variables
│   ├── plan-output.txt     # Terraform plan proof (4 resources)
│   └── terraform.tfvars.example
└── .github/
└── workflows/
└── deploy.yml      # Full CI/CD pipeline
```

---

## CI/CD Pipeline Breakdown

| Step | Tool | What Happens |
| --- | --- | --- |
| Code push | GitHub | Triggers the workflow on master branch |
| Auth to AWS | OIDC | Keyless auth — no long-lived secrets |
| Vulnerability scan | Trivy | Blocks deploy if CRITICAL CVEs found |
| Build image | Docker | Builds from `app/Dockerfile` |
| Push image | Amazon ECR | Tagged with git SHA + latest |
| Deploy | ECS | Forces new deployment, waits for stability |
| Observe | CloudWatch | Logs + CPU/memory alarms |

---

## Security Highlights

- **No hardcoded AWS keys** — GitHub Actions uses OIDC to assume an IAM role
- **Least privilege IAM** — role can only push to ECR and update ECS, nothing else
- **Vulnerability scanning** — Trivy blocks the pipeline on critical CVEs before any image is pushed
- **Private subnet** — ECS tasks have no public IP, only reachable via ALB
- **Security group chaining** — ECS only accepts traffic from the ALB security group ID
- **Image lifecycle policy** — ECR keeps only the last 5 images, reducing storage cost and attack surface

---

## Terraform Plan Output

Validated with `terraform plan` — **4 resources, 0 errors.**

| Resource | Purpose |
| --- | --- |
| `aws_ecr_repository` | Private Docker image registry |
| `aws_ecr_lifecycle_policy` | Auto-expire old images, keep last 5 |
| `aws_iam_role` | GitHub Actions OIDC role |
| `aws_iam_role_policy` | ECR push + ECS deploy permissions |

Full plan output: [terraform/plan-output.txt](./terraform/plan-output.txt)

---

## How to Use

```bash
# 1. Clone the repo
git clone https://github.com/007gregious/Cloud-Engineering-Journey.git

# 2. Navigate to capstone terraform
cd 08-capstone/terraform

# 3. Copy and fill in your variables
cp terraform.tfvars.example terraform.tfvars

# 4. Initialise and validate
terraform init
terraform validate

# 5. Preview infrastructure
terraform plan
```

---

## Infrastructure (provisioned via 05-iac)

The full AWS infrastructure backing this capstone lives in [05-iac](../05-iac/):

- Custom VPC — `10.0.0.0/16`
- Public subnets (x2) — ALB and Bastion Host
- Private subnet — ECS Fargate tasks
- Internet Gateway + NAT Gateway
- Application Load Balancer
- ECS Cluster + Task Definition + Service
- Security Groups — ALB, ECS, Bastion
- IAM Role — ECS task execution
- CloudWatch — log group + CPU/memory alarms

Full Terraform plan: [05-iac/plan-output.txt](../05-iac/plan-output.txt)
