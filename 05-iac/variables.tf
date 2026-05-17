variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for tagging all resources"
  type        = string
  default     = "cloud-journey"
}

variable "admin_ip" {
  description = "Your public IP address for Bastion SSH access (format: x.x.x.x/32)"
  type        = string
}
