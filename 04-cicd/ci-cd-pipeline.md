# Problem

Manual build and deployment processes create bottlenecks:

- Slow and repetitive workflows  

- High risk of human error  

- Inconsistent deployments  

- Difficult to scale development processes  

> Manual deployments don’t scale in modern cloud environments.

## Solution

Implement **CI/CD pipelines** using GitHub Actions to:

- Automate build and deployment processes

- Ensure consistency across environments

- Reduce manual errors

- Enable faster and more reliable releases  

## Architecture

- Code changes trigger automated workflows  

- Pipeline handles build and deployment  

## Implementation Steps

### Step 1: Create Workflow File

```yaml id="workflow-file"
name: Deploy App

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Build Docker image
        run: docker build -t my-app .
```

### Step 2: Push to GitHub

- Committed and pushed code to main branch

- Triggered workflow automatically

### Step 3: Monitor Pipeline

- Navigated to GitHub → Actions tab

- Observed build process execution

## Key Learning

- CI/CD automates software delivery pipelines

- GitHub Actions enables event-driven automation

- Workflows run on triggers (e.g., push events)

- Automation improves speed, consistency, and reliability

## Challenges Faced

- Understanding workflow syntax (YAML)

- Debugging pipeline errors

- Initial confusion around triggers and jobs

### Solution to the Challenges

- Broke down workflow structure:

  - Events → Jobs → Steps

- Used logs in Actions tab for debugging

- Tested with multiple commits

## Security Considerations

- Store secrets using GitHub Secrets

- Avoid hardcoding credentials in workflows

- Limit permissions for workflows

- Use trusted actions only

## Future Improvements

- Push Docker image to Docker Hub automatically

- Add deployment stage (e.g., EC2 or Kubernetes)

- Implement testing stage before build

- Use multi-stage pipelines

## Commands Used

```bash
# Initialize git repo
git init

# Add files
git add .

# Commit changes
git commit -m "Add CI/CD workflow"

# Push to GitHub
git push origin main
```

## Screenshots

![Git Hub Workflow Image](/images/day-8-imgs/Actual-workflow-Screenshot%202026-05-02%20212318.jpg)

![Git Hub Image for YAML File](/images/day-8-imgs/Screenshot%202026-05-02%20211917.jpg)

![Git Hub Image for Workflow](/images/day-8-imgs/Workflow-Screenshot%202026-05-02%20212140.jpg)
