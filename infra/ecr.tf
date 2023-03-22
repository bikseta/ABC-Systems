# Define the ECR repository for Ghost
resource "aws_ecr_repository" "ghost" {
  name = "ghost"

  image_tag_mutability = "IMMUTABLE"

  lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description = "Expire images older than 14 days"
        selection = {
          tagStatus = "untagged"
          countType = "sinceImagePushed"
          countUnit = "days"
          countNumber = 14
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

output "ecr_repository_url" {
  value = aws_ecr_repository.ghost.repository_url
}
