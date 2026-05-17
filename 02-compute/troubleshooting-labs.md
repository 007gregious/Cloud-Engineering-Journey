# Problem

This project focused on one of the most important skills in cloud engineering:

> Troubleshooting.

Because in real-world environments, systems fail and engineers are expected to diagnose and resolve issues quickly.

Modern cloud systems are distributed and complex.

Common issues include:

- Containers failing to start  

- Applications becoming inaccessible  

- Incorrect networking configurations

- Services crashing unexpectedly  

> Engineers are not paid because “everything works.”
> They are paid because they can fix things when they break.

## Solution

Use systematic troubleshooting techniques to:

- Identify root causes

- Analyze logs and service states  

- Verify networking and configurations

- Restore application availability

## Scenario 1 – Broken Nginx Container

### Step 1: Run Invalid Container

```bash id="broken-nginx"
kubectl run broken-nginx --image=nginx:fake
```

### Step 2: Investigate Pod

```bash
kubectl get pods
kubectl describe pod broken-nginx
```

**Observation:**

- Pod failed to start

- Invalid image tag caused image pull failure

## Scenario 2 – Wrong Port Exposure

### Step 1: Expose Wrong Port

- Intentionally configured incorrect service port

### Step 2: Debug Connectivity Issue

```bash
kubectl get svc
kubectl describe svc
```

**Observation:**

- Service port did not match container port

- Application became inaccessible

## Scenario 3 – EC2 Troubleshooting

### Step 1: Stop Nginx Service

```bash
sudo systemctl stop nginx
```

### Step 2: Investigate Issue

```bash
systemctl status nginx
journalctl -u nginx
```

**Observation:**

- Nginx service inactive

- Website inaccessible because web server was stopped

## Key Learning

- Troubleshooting requires a structured approach

- Logs provide critical diagnostic information

- Small misconfigurations can cause major outages

- Kubernetes and Linux provide powerful debugging tools

## Security Considerations

- Avoid exposing unnecessary ports

- Restrict access using security groups and network policies

- Monitor logs securely

- Use least privilege access principles

## Commands Used

```bash
# Run broken container
kubectl run broken-nginx --image=nginx:fake

# View pods
kubectl get pods

# Describe pod
kubectl describe pod broken-nginx

# View services
kubectl get svc

# Describe service
kubectl describe svc

# Stop nginx
sudo systemctl stop nginx

# Check nginx status
systemctl status nginx

# View nginx logs
journalctl -u nginx
```
