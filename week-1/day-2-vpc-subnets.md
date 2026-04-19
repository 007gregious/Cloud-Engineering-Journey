# Architecture Overview

- Created a custom VPC (10.0.0.0/16)
- Public subnet for internet-facing resources
- Private subnet for internal resources
- Internet Gateway attached to VPC
- Route table configured for public subnet

## Key Learning

Even if a security group allows traffic, without a route to an Internet Gateway and a public IP, the instance is not reachable from the internet.

## Challenge Faced

- Initial confusion accessing private instance directly

## Solution

- Used public EC2 as a bastion host
- SSH from public → private instance using private IP

## ScreenSchots

![VPC A CIDR Setup](/images/day-2-imgs/vpc-a-cidr-block.JPG)

![VPC A Private IP Setup](/images/day-2-imgs/vpc-a-priate-ip.JPG)

![VPC A Setup](/images/day-2-imgs/vpc-a-subnet1-pub-ip.JPG)

![VPC B Setup](/images/day-2-imgs/vpc-b-cidr-block.JPG)

![VPC B Setup](/images/day-2-imgs/vpc-b-subnet-private-ip.JPG)

![VPC Peering Setup](/images/day-2-imgs/vpc-peering-connection-active.JPG)
