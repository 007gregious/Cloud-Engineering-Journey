# Problem

Traditional application deployment faces several issues:

- “It works on my machine” inconsistencies  

- Environment differences (OS, dependencies)  

- Heavy and slow virtual machines  

- Difficult scaling and portability  

## Solution

I used **Docker containers** to:

- Package applications with all dependencies

- Ensure consistency across environments

- Enable lightweight and fast deployments

- Improve scalability and portability  

## Architecture

![AWS Containers Architecture Diagram](/03-containers/containers/containers.drawio.png)

- Docker runs containers on EC2  

- Nginx container serves web traffic  

- Port 80 exposed to the internet  

## Implementation Steps

### Step 1: Installed Docker on EC2

```bash id="docker-install"
sudo yum install docker -y

sudo systemctl start docker

sudo systemctl enable docker
```

### Step 2: Run Nginx Container

```bash
sudo docker run -d -p 80:80 nginx
```

- `-d` → run in background

- `-p 80:80` → map container port to host

### Step 3: Access Application

- Open browser

- Visit:

```bash
http://<your-ec2-public-ip>
```

🎉 Nginx running inside a container!

### Step 4: Verify Containers

```bash
docker ps
```

## Why Docker Was Used

Docker ensures application consistency across environments by packaging dependencies and configurations into a single container image.

## Key Learning

- Containers package apps + dependencies together

- Docker ensures environment consistency

- Containers are lightweight compared to VMs

- Fast startup and efficient resource usage

## Challenge Faced

- Permission issues running Docker commands

- Understanding port mapping (`-p 80:80`)

- Initial confusion between containers and virtual machines

## Solution to the Challenge

- Used `sudo` for Docker commands (or added user to docker group)

- Practiced container lifecycle commands

- Studied differences between VM and containers

## Security Considerations

- Avoid running containers as root where possible

- Limit exposed ports

- Use trusted Docker images

- Regularly update images and containers

- Scan images for vulnerabilities

## Future Improvements

- Push image to Docker Hub

- Use Docker Compose for multi-container apps

- Deploy container to AWS ECS

## Commands Used

```bash
# Install Docker
sudo yum install docker -y

# Start Docker
sudo systemctl start docker

# Enable Docker on boot
sudo systemctl enable docker

# Run container
sudo docker run -d -p 80:80 nginx

# List running containers
docker ps

# Dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html

#Docker Build
docker build -t custom-nginx .
docker run -d -p 80:80 custom-nginx
```

## Screenshots

![AWS ECS Cluster](/images/day-7-imgs/ecs-cluster.JPG)

![AWS ECS Configuration](/images/day-7-imgs/ecs-config.JPG)

![AWS Grafana Service](/images/day-7-imgs/grafana-running-service.JPG)

![AWS Grafana Service](/images/day-7-imgs/grafana-running-service3.JPG)
