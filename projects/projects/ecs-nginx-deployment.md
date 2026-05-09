# Problem

Running containers manually becomes difficult as applications grow.

Challenges include:

- Manual container management

- Poor scalability  

- Downtime during failures  

- No automated orchestration  

- Difficult deployment management  

> Running one container is easy. Managing many is not.

---

## Solution

Used **Amazon ECS with Fargate** to:

- Orchestrate container deployments  

- Automatically manage infrastructure  

- Improve scalability and availability  

- Eliminate the need to manage servers directly  

## Architecture

- ECS manages container orchestration  
- Fargate handles serverless compute  
- Containers run without managing EC2 instances  

## Implementation Steps

### Step 1: Opened ECS Console

- Navigated to AWS ECS service

### Step 2: Created ECS Cluster

- Launch type:
  - **Fargate**

### Step 3: Created Task Definition

Used Nginx image:

```text id="ecs-nginx"
nginx
```

Configured:

- CPU and memory

- Container port mappings

### Step 4: Created ECS Service

- Launched service from task definition

- Selected Fargate launch type

- Configured networking

### Step 5: Accessed the Application

- Accessed application through public endpoint

- Verified Nginx container was running successfully

## Key Learning

- ECS helps orchestrate and manage containers

- Fargate removes the need to manage servers

- Container orchestration improves reliability and scalability

- Services maintain desired container state automatically

## Challenge Faced

- Understanding ECS concepts:

  - Cluster
  - Task Definition
  - Service

- Networking configuration for public access

- Initial confusion around Fargate vs EC2 launch types

## Solution to the Challenge

- Broke ECS into smaller components:

  - Cluster → environment
  - Task Definition → container blueprint
  - Service → keeps containers running

- Configured proper security groups and networking

- Verified port mappings and public IP assignment

## Security Considerations

- Restrict unnecessary inbound traffic

- Use least privilege IAM roles

- Avoid exposing containers publicly unless required

- Use load balancers and HTTPS in production

- Store secrets securely using AWS Secrets Manager or Parameter Store

## Future Improvements

- Add Application Load Balancer (ALB)

- Deploy multi-container applications

- Implement auto scaling

- Integrate CI/CD pipeline for deployments

- Use custom Docker images instead of public defaults

## Commands Used

```bash
# Example Docker image used
nginx

# Verify running containers locally
docker ps

```

## Stretched Task – Load Balancer

**Optional Upgrade:**

- Explored adding:

  - An application Load Balancer (ALB)

**Benefits:**

- Better traffic distribution

- Improved availability

- Easier scaling

## Screenshots

![AWS ECS Cluster dashboard](/images/day-9-imgs/ecs-cluster.JPG)

![AWS ECS Configuration](/images/day-9-imgs/ecs-config.JPG)

![AWS ECS Dashboard](/images/day-9-imgs/grafana-pub-subnet.JPG)
