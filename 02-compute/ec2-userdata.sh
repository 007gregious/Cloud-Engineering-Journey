#!/bin/bash
# EC2 User Data script — installs and starts nginx on launch

sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

echo "EC2 nginx setup complete." > /var/log/userdata.log
