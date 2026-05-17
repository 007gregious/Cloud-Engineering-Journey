# Linux Troubleshooting & System Administration Tasks

## The Problem

As part of my Cloud Engineering journey, I carried out hands-on Linux troubleshooting and system administration tasks focused on investigating processes, monitoring system resources, managing services, checking disk usage, and working with Linux permissions.

The goal was to build practical troubleshooting skills commonly required in real-world cloud and DevOps environments.

## Solution

I used essential Linux commands and tools to:

- Investigate running processes

- Identify services listening on ports

- Monitor CPU and memory usage

- Check disk utilization

- Manage system services like Nginx

- Experiment with Linux file permissions and ownership

I also explored troubleshooting steps for diagnosing an inaccessible EC2-hosted website before concluding that AWS infrastructure was the root cause.

## Implementation Steps

### Process Investigation

```bash
ps aux
top
htop
```

### Port Investigation

```bash
sudo netstat -tulpn
```

OR

```bash
sudo ss -tulpn
```

### Disk Usage Check

```bash
df -h
du -sh /
```

### Service Management

```bash
sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl status nginx
```

### Permissions Management

```bash
touch devops.txt
chmod 644 devops.txt
sudo chown ubuntu:ubuntu devops.txt
```

## Key Learning

- Learned how to investigate Linux processes and identify high-resource consumption

- Understood how to check which services are listening on specific ports

- Gained experience managing Linux services using `systemctl`

- Improved understanding of Linux permissions and ownership

- Learned practical troubleshooting steps for EC2-hosted applications

## Challenge Faced

One challenge encountered was identifying why a service became inaccessible despite the EC2 instance still running normally.

## Solution to the Challenge

Before assuming AWS was the issue, I performed several Linux-level checks including:

- Verifying if Nginx was running

- Checking if port 80 was listening

- Inspecting system resource usage

- Reviewing disk space availability

- Checking firewall and permission configurations

- Inspecting logs for service errors

This helped isolate whether the issue originated from the operating system or application layer instead of AWS infrastructure.

## Security Considerations

- Used `sudo` privileges carefully to avoid unintended system modifications

- Applied proper file permissions using `chmod`

- Ensured ownership settings were correctly configured with `chown`

- Verified only required services were exposed on listening ports

## Future Improvements

- Automate monitoring using CloudWatch or Prometheus

- Implement centralized logging

- Add alerting for resource spikes and service failures

- Explore advanced Linux troubleshooting techniques

## Commands Used

```bash
ps aux
top
htop
sudo netstat -tulpn
sudo ss -tulpn
df -h
du -sh /
sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl status nginx
touch devops.txt
chmod
chown
```

---
