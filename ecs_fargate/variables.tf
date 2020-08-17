##########################
# Global Enviroment variables

variable "aws_region" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC id where this stack will run"
  default = "vpc-a4c54ac3"
}

variable "subnet_external_id" {
  description = "subnet id where the alb will receive traffic"
  default = ["subnet-01d4d33c", "subnet-10cc551c"]
}

variable "subnet_internal_id" {
  description = "subnet id that will handle ecs cluster"
  default = ["subnet-1dec9978", "subnet-3a3d1210"]
}


variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "1"
}


###########################
# Fargate cluster vars

variable "fargate_cluster_name" {
  description = "The fargate cluster name"
  default     = "mytec-prod-monitoring"
}


###########################
# Task definition variables

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "docker.elastic.co/kibana/kibana:7.8.1"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5601
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "2048"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

