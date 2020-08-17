
provider "aws" {
  shared_credentials_file = "../.aws_credentials"
  profile                 = "default"
  region                  = var.aws_region
}


###############################
# Creating ECS Fargate Cluster

resource "aws_ecs_cluster" "main" {
  name = var.fargate_cluster_name
}


###############################
# Loading container parameters
data "template_file" "kibana_app" {
  template = file("./templates/ecs_fargate/kibana.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}


###############################
# Creating task definition
resource "aws_ecs_task_definition" "app" {
  family                   = "farfate-taskdef-kibana"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.kibana_app.rendered
}


###############################
# Creating fargate service

resource "aws_ecs_service" "main" {
  name            = "fargate-service-kibana"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.subnet_internal_id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.tgtgrp-kibana.id
    container_name   = "kibana"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}


