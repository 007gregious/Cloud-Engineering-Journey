# Cloud Engineering Journey

A structured, hands-on portfolio documenting my path to a Junior Cloud/DevOps Engineer role.
Every project includes architecture diagrams, documentation, and real working code.

---

## 🗺️ Architecture — GitHub to Production

```file
Developer → GitHub Repo → GitHub Actions → Amazon ECR
                    ↓
                Terraform
                    ↓
        ┌────── Custom VPC ──────┐
        │  Public Subnet         │
        │  ┌──────────────────┐  │
        │  │ Internet Gateway │  │
        │  │ ALB              │  │
        │  │ Bastion Host     │  │
        │  └──────────────────┘  │
        │  Private Subnet        │
        │  ┌──────────────────┐  │
        │  │ ECS — nginx app  │  │
        │  │ Security Group   │  │
        │  └──────────────────┘  │
        └────────────────────────┘
                    ↓
        IAM Role · CloudWatch
```

---

## 📁 Projects

| # | Folder | What's Inside | Key File |
| --- | -------- | --------------- | ---------- |
| 01 | [Networking](./01-networking/) | VPC, subnets, Bastion Host architecture | [bastion-setup.sh](./01-networking/bastion-setup.sh) |
| 02 | [Compute](./02-compute/) | EC2, nginx, S3 static site, Linux labs | [ec2-userdata.sh](./02-compute/ec2-userdata.sh) |
| 03 | [Containers](./03-containers/) | Docker, ECS, Kubernetes nginx deployments | [Dockerfile](./03-containers/Dockerfile) |
| 04 | [CI/CD](./04-cicd/) | GitHub Actions pipeline — build, push, deploy | [deploy.yml](./04-cicd/.github/workflows/deploy.yml) |
| 05 | [IaC](./05-iac/) | Terraform — VPC, subnets, IGW | [main.tf](./05-iac/main.tf) |
| 06 | [Monitoring](./06-monitoring/) | CloudWatch alarms, CPU and memory metrics | [cloudwatch-alarms.sh](./06-monitoring/cloudwatch-alarms.sh) |
| 07 | [Security](./07-security/) | IAM roles, least-privilege policy | [iam-policy.json](./07-security/iam-policy.json) |
| 08 | [Capstone](./08-capstone/) | Full end-to-end deployment pipeline (in progress) | [README](./08-capstone/README.md) |

---

## 🛠️ Tools & Technologies

![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=githubactions&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black)

---

## 📊 Progress Tracker

- [x] Phase 1 — Repo structure + real code files
- [ ] Phase 2 — Complete Terraform (full ECS + ALB + security groups)
- [ ] Phase 3 — Capstone end-to-end pipeline
- [ ] Phase 4 — AWS Cloud Practitioner certification
- [ ] Phase 5 — AWS Solutions Architect Associate

---

## 👤 About

Junior Cloud/DevOps Engineer in training.
Focused on AWS, Infrastructure as Code, and CI/CD automation.

[![GitHub](https://img.shields.io/badge/GitHub-007gregious-181717?style=flat&logo=github)](https://github.com/007gregious)
