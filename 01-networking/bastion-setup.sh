#!/bin/bash
# Bastion Host initial setup script

# Update system
sudo apt update -y && sudo apt upgrade -y

# Harden SSH — disable password auth
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install basic tools
sudo apt install -y curl wget net-tools

echo "Bastion host hardened and ready."
