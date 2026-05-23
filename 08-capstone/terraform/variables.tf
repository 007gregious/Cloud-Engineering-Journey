variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "Your 12-digit AWS account ID"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "cloud-journey"
}
