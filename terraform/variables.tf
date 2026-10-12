variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-2" # Change to your region if different
}

variable "project_name" {
  description = "Project prefix name (keep short to prevent IAM name prefix errors)"
  type        = string
  default     = "devshop"
}
