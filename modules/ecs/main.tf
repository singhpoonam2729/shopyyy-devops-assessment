resource "aws_ecs_cluster" "main" {

name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "backend" {

family                   = "backend-api"

network_mode             = "awsvpc"

requires_compatibilities = ["FARGATE"]

cpu    = 512
memory = 1024

execution_role_arn = aws_iam_role.ecs_execution_role.arn

container_definitions = jsonencode([
{
name  = "backend"

  image = "nginx:latest"

  essential = true

  portMappings = [
    {
      containerPort = 3000
      protocol      = "tcp"
    }
  ]

  environment = [
    {
      name  = "DATABASE_URL"
      value = var.database_url
    },

    {
      name  = "REDIS_URL"
      value = var.redis_url
    }
  ]
}

])
}

resource "aws_ecs_service" "backend" {

name = "${var.project_name}-backend"

cluster = aws_ecs_cluster.main.id

task_definition = aws_ecs_task_definition.backend.arn

desired_count = 2

launch_type = "FARGATE"

network_configuration {

assign_public_ip = false

security_groups = [
  var.ecs_sg
]

subnets = [
  var.private_subnet_a,
  var.private_subnet_b
]

}

load_balancer {

target_group_arn = var.target_group_arn

container_name = "backend"

container_port = 3000

}
}

resource "aws_iam_role" "ecs_execution_role" {

name = "${var.project_name}-ecs-execution-role"

assume_role_policy = jsonencode({
Version = "2012-10-17"

Statement = [
  {
    Action = "sts:AssumeRole"

    Effect = "Allow"

    Principal = {
      Service = "ecs-tasks.amazonaws.com"
    }
  }
]


})
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {

role       = aws_iam_role.ecs_execution_role.name

policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

