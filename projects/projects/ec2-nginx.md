# Linux + EC2 Basics

Welcome to the beginning of my Cloud Engineering journey!

This project aims to dive into the fundamentals of working with Linux on an EC2 instance not just running commands, but understanding *what’s actually happening under the hood.*

---

## Objective

To gain hands-on experience with:

- Launching and connecting to a cloud server

- Navigating a Linux environment

- Installing and running a web server (Nginx)

- Understanding real-world networking issues in AWS

---

## Key Concepts

### What happens when you SSH into an EC2 instance?

When you SSH into an EC2 instance:

- You establish a **secure encrypted connection** between your local machine and the remote server

- Authentication is done using a **key pair (.pem file)**

- You gain **terminal access** to interact with the Linux OS

---

### Key Linux & Package Concepts

#### `chmod 400 key.pem`

- Restricts file permissions
- Ensures only the owner can read the key
- Required for SSH to accept the key (security enforcement)

#### `sudo su`

- Switches to the **root user**

- Gives full administrative privileges

- Use with caution ⚠️

#### `apt vs yum`

| Tool | OS Type |
| ------ | -------- |
| `apt` | Ubuntu/Debian |
| `yum` | Amazon Linux / RHEL |

Both are **package managers** used to install and manage software.

---

## What I Built

### Step 1: I Launched an EC2 Instance

- Created an EC2 instance (Amazon Linux / Ubuntu)

- Configured key pair for SSH access

---

### Step 2: I Connected via SSH

```bash  
ssh -i key.pem ec2-user@<public-ip>
```

### Step 3: Basic Linux Commands I used

```bash
whoami   # Current user
pwd      # Present working directory
ls -la   # List all files (including hidden)
```

### Step 4: I Installed Nginx

Amazon Linux:

```bash
sudo yum update -y
sudo yum install nginx -y
```

Ubuntu:

```bash
sudo apt update
sudo apt install nginx -y
```

### Step 5: Started Nginx

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

### Step 6: Open Port 80

- Edited Security Group

- Allowed inbound HTTP (port 80)

### Step 7: Access in Browser

`http://<your-public-ip>`

Nginx default page displayed successfully!

### Challenges Faced

I could not access the web server from the browser
Even though:

- Nginx was running
- And Instance was active

### Solution

The issue was due to a closed Security Group port (port 80).

**Fix:**
I added inbound rule:

- Type: HTTP

- Port: 80

- Source: 0.0.0.0/0

## Lessons Learned

- Running a service ≠ making it accessible

- AWS Security Groups act as a firewall layer

- You must explicitly allow traffic (default = deny)

- Always troubleshoot in layers:

1. Application (Is Nginx running?)
2. OS (Is port open?)
3. Network (Security Group rules)
4. Public access (IP + routing)

### ScreenShot

![Nginx Setup](/images/day-1-imgs/My-AltSchool-Exam-Shot.JPG)

### Mini Challenge Answer

Why couldn’t you access your server before opening port 80, even though Nginx was running?

**Because:**

The AWS Security Group was blocking inbound HTTP traffic.

Even though Nginx was active, external requests could not reach the instance because AWS blocks all incoming traffic by default unless explicitly allowed.

This project reinforced a key Cloud Engineering principle:

"If users can’t reach your app, always check the network before the code."
