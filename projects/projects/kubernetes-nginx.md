# Problem

Running containers manually becomes difficult in large-scale environments.

Challenges include:

- Managing multiple containers manually

- Handling failures and restarts  

- Scaling applications efficiently  

- Load balancing traffic  

- Maintaining high availability  

> Containers alone are not enough at scale.

## Solution

Use **Kubernetes** to orchestrate containers automatically.

Kubernetes helps with:

- Automated deployment

- Scaling applications

- Self-healing containers  

- Service discovery and networking  

- High availability  

## Architecture

![Kubernetes Architectural Diagram](/diagrams/kubernetes-nginx/kubernetes-nginx.drawio.png)

### Components

- **Pod** → smallest deployable unit in Kubernetes  

- **Deployment** → manages Pods and desired state  

- **Service** → exposes application/network access  

## Implementation Steps

### Step 1: Start Kubernetes Environment

Used:

- Minikube  
OR
- Docker Desktop Kubernetes

### Step 2: Created Deployment

```bash id="k8s-deployment"
kubectl create deployment nginx --image=nginx
```

### Step 3: Exposed Deployment

```bash
kubectl expose deployment nginx --type=LoadBalancer --port=80
```

### Step 4: Verified Resources

```bash
kubectl get pods
kubectl get services
kubectl get deployments
```

### Step 5: Access Application

- Verified running Nginx deployment

## Key Learning

- Kubernetes manages containers at scale

- Pods are the smallest execution units

- Deployments maintain desired application state

- Services expose applications to users and other services

- Kubernetes provides automation and resilience

## Challenge Faced

- Understanding Kubernetes architecture

- Differentiating Pods, Deployments, and Services

- Initial confusion around how components interact

## Solution to the Challenge

- Broke Kubernetes into smaller concepts:

  - Pod → runs containers

  - Deployment → manages Pods

  - Service → exposes Pods/network access

- Used kubectl get commands repeatedly to visualize resources

## Security Considerations

- Avoid exposing unnecessary services publicly

- Use RBAC (Role-Based Access Control)

- Limit container privileges

- Use trusted container images

- Secure cluster access and credentials

## Stretched Task – Scaling

**Command Used:**

```bash
kubectl scale deployment nginx --replicas=3
```

**Result:**

- Kubernetes automatically created additional Pods 📈

- Verified scaling using:
kubectl get pods

## Future Improvements

- Deploy multi-container applications

- Add ingress controller

- Implement autoscaling

- Use Helm charts for package management

- Deploy Kubernetes cluster on AWS EKS

## Commands Used

```bash
# Create deployment
kubectl create deployment nginx --image=nginx

# Expose deployment
kubectl expose deployment nginx --type=LoadBalancer --port=80

# View pods
kubectl get pods

# View services
kubectl get services

# View deployments
kubectl get deployments

# Scale deployment
kubectl scale deployment nginx --replicas=3
```
