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