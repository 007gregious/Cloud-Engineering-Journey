#!/bin/bash
# Create CloudWatch alarms for ECS service

CLUSTER_NAME="cloud-journey-cluster"
SERVICE_NAME="nginx-service"
SNS_TOPIC_ARN="arn:aws:sns:us-east-1:YOUR_ACCOUNT_ID:cloud-journey-alerts"

# CPU utilisation alarm
aws cloudwatch put-metric-alarm \
  --alarm-name "ECS-High-CPU" \
  --metric-name CPUUtilization \
  --namespace AWS/ECS \
  --dimensions Name=ClusterName,Value=$CLUSTER_NAME Name=ServiceName,Value=$SERVICE_NAME \
  --statistic Average \
  --period 60 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2 \
  --alarm-actions $SNS_TOPIC_ARN

# Memory utilisation alarm
aws cloudwatch put-metric-alarm \
  --alarm-name "ECS-High-Memory" \
  --metric-name MemoryUtilization \
  --namespace AWS/ECS \
  --dimensions Name=ClusterName,Value=$CLUSTER_NAME Name=ServiceName,Value=$SERVICE_NAME \
  --statistic Average \
  --period 60 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2 \
  --alarm-actions $SNS_TOPIC_ARN

echo "CloudWatch alarms created."
