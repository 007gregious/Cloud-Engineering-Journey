# Infrastructure as Code — Terraform

Full AWS infrastructure for the Cloud Engineering Journey project.
Validated with `terraform plan` — 26 resources, 0 errors.

## Resources Provisioned

| Resource | Name | Purpose |
| --- | --- | --- |
| VPC | cloud-journey-vpc | Isolated network, 10.0.0.0/16 |
| Public Subnet A | cloud-journey-public-subnet | ALB, Bastion Host |
| Public Subnet B | cloud-journey-public-subnet-b | ALB second AZ |
| Private Subnet | cloud-journey-private-subnet | ECS tasks |
| Internet Gateway | cloud-journey-igw | Public internet access |
| NAT Gateway | cloud-journey-nat-gw | Outbound access for private subnet |
| Route Tables | public + private | Traffic routing rules |
| ALB | cloud-journey-alb | Public-facing load balancer |
| ALB Target Group | cloud-journey-tg | Routes traffic to ECS tasks |
| ALB Listener | port 80 | Forwards HTTP to target group |
| ECS Cluster | cloud-journey-cluster | Container orchestration |
| ECS Task Definition | cloud-journey-task | nginx:alpine, 256 CPU / 512 MB |
| ECS Service | cloud-journey-service | Runs 1 task, Fargate launch type |
| Security Group — ALB | cloud-journey-alb-sg | Allows 80/443 from internet |
| Security Group — ECS | cloud-journey-ecs-sg | Allows 80 from ALB only |
| Security Group — Bastion | cloud-journey-bastion-sg | Allows SSH from admin IP only |
| IAM Role | cloud-journey-ecs-execution-role | ECR pull + CloudWatch logs |
| CloudWatch Log Group | /ecs/cloud-journey | ECS task stdout/stderr |
| CloudWatch Alarm — CPU | cloud-journey-high-cpu | Alerts above 80% CPU |
| CloudWatch Alarm — Memory | cloud-journey-high-memory | Alerts above 80% memory |

## File Structure

```makefile
05-iac/
├── main.tf          # VPC, subnets
├── vpc.tf           # IGW, NAT, route tables
├── security.tf      # Security groups
├── iam.tf           # ECS execution role
├── alb.tf           # Load balancer
├── ecs.tf           # Cluster, task, service
├── cloudwatch.tf    # Alarms and log group
├── variables.tf     # Input variables
├── outputs.tf       # VPC and subnet IDs
└── plan-output.txt  # Terraform plan proof
```

## How to Use

```bash
# Initialise
terraform init

# Validate
terraform validate

# Preview
terraform plan
```

> Note: `terraform.tfvars` is excluded from version control.
> Copy `terraform.tfvars.example` and fill in your values.
EOF
