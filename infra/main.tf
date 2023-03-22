provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "ghost" {
  name = "ghost"
}

resource "aws_ecs_task_definition" "ghost" {
  family                   = "ghost"
  container_definitions    = file("${path.module}/imagedefinitions.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
}

resource "aws_ecs_service" "ghost" {
  name                   = "ghost"
  cluster                = aws_ecs_cluster.ghost.id
  task_definition        = aws_ecs_task_definition.ghost.arn
  desired_count          = 1
  launch_type            = "FARGATE"
  network_configuration {
    security_groups = [aws_security_group.ghost.id]
    subnets         = aws_subnet.ghost.*.id
  }
  depends_on = [aws_lb_target_group_attachment.ghost]
}

resource "aws_lb_target_group_attachment" "ghost" {
  target_group_arn = aws_lb_target_group.ghost.arn
  target_id        = aws_ecs_service.ghost.id
  port             = 2368
}

resource "aws_lb_target_group" "ghost" {
  name     = "ghost"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_security_group" "ghost" {
  name_prefix = "ghost"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 2368
    to_port   = 2368
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "ghost" {
  count = length(var.subnet_ids)
  id    = var.subnet_ids[count.index]
}

resource "aws_ecs_cluster" "ghost" {
  name = "ghost"
}