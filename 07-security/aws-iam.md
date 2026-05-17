# Problem

Using the AWS root account for daily operations is **highly insecure** and violates best practices.

Key issues:

- Root has **unrestricted access**

- No granular control or auditing

- High risk if credentials are compromised

Additionally:

- Applications running on EC2 often rely on **hardcoded access keys**, which is unsafe

## Solution

- Created an IAM user for daily access

- Assigned permissions using managed policies

- Used IAM roles instead of storing credentials on EC2

- Attached roles directly to EC2 instances for secure access

## Architecture

![AWS IAM Diagram](/diagrams/aws-iam/aws-iam.drawio.png)

- IAM User → used for login and management  

- IAM Role → attached to EC2 for secure resource access  

- S3 → accessed without storing credentials  

## Implementation Steps

### Archtecture Overview

- Created IAM user: `cloud-user`

- Enabled:
  - Programmatic access

  - Console access

### Attached Permissions

- Attached policy:
  - `AmazonEC2FullAccess`

### Login as IAM User

- Signed out of root account

- Logged in using IAM credentials

### Created IAM Role

- Role type: EC2

- Attached policy:

  - `AmazonS3ReadOnlyAccess`

### Attached Role to EC2

- Assigned IAM role to running EC2 instance

### Tested Access

From EC2:

```bash
aws s3 ls
```

Successfully listed S3 buckets without access keys

## Key Learning

- Root account should never be used for daily operations

- IAM enables fine-grained access control

- IAM Roles eliminate the need for storing credentials

- Security Groups control network access, IAM controls permissions

## Challenge Faced

- Understanding the difference between:

- IAM User vs Role vs Policy

- Initial confusion around why EC2 didn’t need access keys

- Permission issues when testing S3 access

## Solution to the Challenge

- Broke down IAM components:

- User → for people

- Role → for services (like EC2)

- Policy → defines permissions

- Verified role attachment to EC2

- Ensured correct policy (`AmazonS3ReadOnlyAccess`) was attached

## Security Considerations

- Avoid using root account

- Do not store AWS access keys on EC2

- Use IAM roles for temporary credentials

- Apply least privilege principle

- Rotate credentials regularly

## Future Improvements

- Create custom IAM policies

- Restrict S3 access to a specific bucket only

- Implement multi-factor authentication (MFA)

- Use AWS Organizations for multi-account security

## Commands Used

```bash
# Verify identity
whoami

# List S3 buckets (after role attachment)
aws s3 ls

# Check AWS configuration
aws configure list
```

## Screenshots

![IAM User Created](/images/day-3-imgs/aws-iam-created.JPG)

![IAM Identity Center](/images/day-3-imgs/aws-iam-id-center.JPG)

![IAM User](/images/day-3-imgs/iam-user-aws-console.JPG)

![Permission Set](/images/day-3-imgs/permission-set-updated.JPG)
