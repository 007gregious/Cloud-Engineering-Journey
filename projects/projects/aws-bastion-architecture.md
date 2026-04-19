# Problem

How do we securely access private servers without exposing them to the internet?

## Solution

* Bastion host in public subnet
* Private EC2 in private subnet
* Controlled SSH access

## Architecture

![AWS Bastion Diagram](/diagrams/bastion-architecture.png/AWS%20Bastion.drawio.svg)

## Implementation Steps

### Architecture Overview

* Created a custom VPC (10.0.0.0/16)

* Public subnet for internet-facing resources

* Private subnet for internal resources

* Internet Gateway attached to VPC

* Route table configured for public subnet

## Key Learning

Even if a security group allows traffic, without a route to an Internet Gateway and a public IP, the instance is not reachable from the internet.

## Challenge Faced

Initial confusion accessing private instance directly

## Solutions

* Used public EC2 as a bastion host

* SSH from public → private instance using private IP

## Security Considerations

* Restricted SSH access via bastion host only

* Private instances not exposed to the internet

* Principle of least privilege (to be implemented with IAM)

## Future Improvements

* Add NAT Gateway for outbound internet access

* Use Terraform for infrastructure provisioning

* Implement IAM roles instead of key-based access

## Commands Used

```bash
ssh -i key.pem ec2-user@public-ip
ssh -i key.pem ec2-user@private-ip
```

```bash
sudo yum install nginx -y
sudo systemctl start nginx
```

## ScreenSchots

![VPC A CIDR Setup](/images/day-2-imgs/vpc-a-cidr-block.JPG)

![VPC A Private IP Setup](/images/day-2-imgs/vpc-a-priate-ip.JPG)

![VPC A Setup](/images/day-2-imgs/vpc-a-subnet1-pub-ip.JPG)

![VPC B Setup](/images/day-2-imgs/vpc-b-cidr-block.JPG)

![VPC B Setup](/images/day-2-imgs/vpc-b-subnet-private-ip.JPG)

![VPC Peering Setup](/images/day-2-imgs/vpc-peering-connection-active.JPG)
