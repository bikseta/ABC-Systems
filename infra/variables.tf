variable "aws_region" {
description = "The AWS region in which to create resources."
default = "eu-west-1"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "aws_account_id" {
description = "The AWS account ID to use."
}

variable "tag" {
description = "The Docker image tag to use."
default = "latest"
}

variable "ecr_repository_name" {
description = "The name of the ECR repository."
default = "ghost"
}

variable "app_name" {
  description = "The name of the application."
}

variable "environment" {
  description = "The name of the environment (e.g. prod, staging, dev)."
}

variable "db_password" {
  description = "The password for the MySQL database user."
  sensitive   = true
}

variable "smtp_password" {
  description = "The password for the SMTP email account."
  sensitive   = true
}

variable "github_repository_owner" {
  description = "The owner of the GitHub repository to use for CodePipeline."
}

variable "github_repository_name" {
  description = "The name of the GitHub repository to use for CodePipeline."
}

variable "github_branch" {
  description = "The GitHub branch to use for CodePipeline."
  default     = "main"
}
