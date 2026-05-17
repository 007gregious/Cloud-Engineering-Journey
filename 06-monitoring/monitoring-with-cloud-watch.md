# Problem

In cloud environments, systems can fail silently without proper visibility.

Key challenges:

- No insight into system performance  

- Difficult to detect issues early

- No alerting when things go wrong  

> Without monitoring, you’re essentially operating blind.

## Solution

Used **Amazon CloudWatch** to:

- Monitor system performance (metrics)

- Collect and analyze logs

- Set alarms for abnormal behavior

- Gain visibility into application and infrastructure health

## Architecture

![Cloud Watch Architecture Diagram](/06-monitoring/cloud-watch/cloud-watch.drawio.png)

- Metrics → quantitative data (CPU, memory, etc.)  

- Logs → detailed event records  

- Alarms → trigger notifications based on thresholds  

## Implementation Steps

### Step 1: Enabled EC2 Monitoring

- Navigated to EC2 → Monitoring tab

- Observed:
  - CPU Utilization  
  - Network In/Out  

### Step 2: Installed CloudWatch Agent

```bash id="cw-agent-install"
sudo yum install amazon-cloudwatch-agent -y
```

### Step 3: Viewed Logs

- Navigated to CloudWatch → Logs

- Explored log groups and streams

### Step 4: Created Alarm

- Metric: CPU Utilization

- Condition: > 70%

- Action: Send notification via SNS

## Key Learning

- Monitoring = observing system health in real-time

- Metrics vs Logs:

  - Metrics → numbers (CPU %, memory, etc.)

  - Logs → detailed records of events

- CloudWatch provides centralized observability

- Alerts help detect issues before users are affected

## Challenges Faced

- Understanding the difference between metrics and logs

- Navigating CloudWatch dashboard

- Setting up alarms correctly

## Solution to the Challenges

- Broke down observability concepts:

  - Metrics = performance indicators
  - Logs = detailed system activity

- Explored CloudWatch UI step-by-step

- Tested alarms to confirm behavior

## Security Considerations

- Restrict access to CloudWatch via IAM roles

- Avoid exposing sensitive data in logs

- Use least privilege for monitoring permissions

- Encrypt logs where necessary

## Future Improvements

- Monitor memory and disk usage using CloudWatch Agent

- Create dashboards for better visualization

- Integrate with Auto Scaling for automated responses

- Use log insights for advanced querying

## Commands Used

```bash
# Install CloudWatch agent
sudo yum install amazon-cloudwatch-agent -y

# Simulate CPU load
yes > /dev/null &
```

## Load Simulation

Command used:

```bash
yes > /dev/null &
```

## Result

- CPU utilization spiked 📈

- Observed real-time changes in CloudWatch metrics

## Screenshots

![AWS Cloud Watch Dashboard](/images/day-5-imgs/cloud-watch-widget-stress-test.JPG)

![AWS Cloud Watch Dashboard](/images/day-5-imgs/cloud-watch-widgets.JPG)

![ECS Cluster on AWS Console](/images/day-5-imgs/ecs-cluster.JPG)

![Nginx Homepage](/images/day-5-imgs/ecs-nginx-home-page.JPG)

![AWS ECS Dashboard](/images/day-5-imgs/ecs-task-def2.JPG)
