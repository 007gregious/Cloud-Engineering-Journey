# Problem

Manual cloud setup via the AWS Console leads to:

- Inconsistent environments

- Human errors (misconfigurations)

- No version control

- Difficult to reproduce infrastructure  

> If something breaks, rebuilding becomes unreliable and time-consuming.

## Solution

I used **Terraform** to define infrastructure as code:

- Infrastructure is written in configuration files  

- Can be version-controlled (Git)  

- Easily reproducible across environments

- Automated deployment and teardown  

## Architecture

- Terraform interacts with AWS via APIs  

- Resources are defined declaratively  

## Implementation Steps

### Step 1: Install Terraform

- I installed Terraform locally

### Step 2: Created Project Folder

```bash
mkdir terraform-ec2
cd terraform-ec2
```

### Step 3: Created `main.tf`

Basic EC2 configuration:

```bash
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-ec2"
  }
}
```

## Step 4: Initialized & Deployed

```bash
terraform init
terraform plan
terraform apply
```

## Step 5: Confirmed Deployment

- I verified EC2 instance in AWS Console ✅

## Key Learning

- Infrastructure can be defined and managed using code

- Terraform enables automation and consistency

- `terraform plan` helps preview changes before applying

- `terraform apply` executes infrastructure changes

## Challenges Faced

- Understanding Terraform syntax (HCL)

- Finding the correct AMI ID

- Initial confusion around Terraform workflow (init → plan → apply)

## Solution to the Challenges

- Referred to Terraform documentation

- Used AWS Console to verify AMI IDs

- Practiced Terraform lifecycle commands repeatedly

## Security Considerations

- Avoid hardcoding sensitive data (use variables or secrets management)

- Use IAM roles instead of embedding credentials

- Apply least privilege principle

- Store Terraform state securely (e.g., remote backend like S3 + DynamoDB)

## Future Improvements

- Add Security Group configuration

- Introduce variables for reusability

- Use Terraform modules

- Store state in remote backend (S3)

- Implement CI/CD for infrastructure deployment

## Commands Used

```bash
# Initialize Terraform project
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply

# Destroy resources (cleanup)
terraform destroy
```
