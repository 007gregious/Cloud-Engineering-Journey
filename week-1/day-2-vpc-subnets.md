# What makes a subnet public vs private?

In Amazon VPC, a subnet is just a range of IPs.

The key difference is NOT the subnet itself it’s the route table attached to it.

## Public Subnet

A subnet is public if:

* It has a route to an Internet Gateway (IGW)

* Example route:
Destination: 0.0.0.0/0
Target: IGW

*This means:*

Resources can reach the internet
AND can potentially be reached from the internet

## Private Subnet

A subnet is private if:

* It does NOT have a route to an IGW

* Example:
No 0.0.0.0/0 → IGW route

*This means:*

No direct internet access
Used for databases, internal services, etc.

* Simple analogy
Public subnet = house with a road to the highway
Private subnet = house inside a gated estate (no direct highway access)

## What is an Internet Gateway (IGW)?

Internet Gateway is:

A bridge between your VPC and the internet

*What it does:*
Allows incoming traffic from the internet
Allows outgoing traffic to the internet
Without IGW:

Even if your instance has a public IP…

* It cannot reach the internet
* The internet cannot reach it

*Think of IGW as:*

The main exit door of your VPC to the internet

### Why does an EC2 instance need these?

Let’s connect everything now.

A) *Why Public IP?*

Your Amazon EC2 instance needs a public IP because:

* The internet needs a way to find your instance

* Without public IP:
Instance only has private IP (e.g., 10.0.1.5)
That IP is not reachable from the internet

*You can’t:*

* SSH from your laptop
* Access via browser

* With public IP:
Your instance is reachable from the internet

B) *Why route to IGW?*

Even with a public IP…

* If there’s no route to IGW, traffic has nowhere to go.

This is the key formula;

* Internet access = Public IP + Route to IGW + Security Group rules

* Miss ONE → ❌ no access

## Full picture (end-to-end)

For you to access your EC2 from your browser you need to check if your:

* EC2 has public IP ✅
* Subnet has route to IGW ✅
* IGW attached to VPC ✅
* Security Group allows traffic (e.g., port 80) ✅

## Challenges Faced

“My instance has a public IP but I still can’t access it”

Solution:

* No IGW route ❌
* OR security group blocking ❌

## Lesson Learned

* Private subnets can still access the internet using:
NAT Gateway (outbound only)

## ScreenSchots

![VPC A CIDR Setup](/images/day-2-imgs/vpc-a-cidr-block.JPG)

![VPC A Private IP Setup](/images/day-2-imgs/vpc-a-priate-ip.JPG)

![VPC A Setup](/images/day-2-imgs/vpc-a-subnet1-pub-ip.JPG)

![VPC B Setup](/images/day-2-imgs/vpc-b-cidr-block.JPG)

![VPC B Setup](/images/day-2-imgs/vpc-b-subnet-private-ip.JPG)

![VPC Peering Setup](/images/day-2-imgs/vpc-peering-connection-active.JPG)
