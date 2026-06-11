resource "aws_security_group" "alb_sg" {
name   = "${var.project_name}-alb-sg"
vpc_id = var.vpc_id

ingress {
description = "HTTPS"
from_port   = 443
to_port     = 443
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port   = 0
protocol  = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "ecs_sg" {
name   = "${var.project_name}-ecs-sg"
vpc_id = var.vpc_id

ingress {
from_port       = 3000
to_port         = 3000
protocol        = "tcp"
security_groups = [aws_security_group.alb_sg.id]
}
}

resource "aws_security_group" "rds_sg" {
name   = "${var.project_name}-rds-sg"
vpc_id = var.vpc_id

ingress {
from_port       = 5432
to_port         = 5432
protocol        = "tcp"
security_groups = [aws_security_group.ecs_sg.id]
}
}

resource "aws_security_group" "redis_sg" {
name   = "${var.project_name}-redis-sg"
vpc_id = var.vpc_id

ingress {
from_port       = 6379
to_port         = 6379
protocol        = "tcp"
security_groups = [aws_security_group.ecs_sg.id]
}
}

resource "aws_security_group" "msk_sg" {
name   = "${var.project_name}-msk-sg"
vpc_id = var.vpc_id

ingress {
from_port       = 9092
to_port         = 9092
protocol        = "tcp"
security_groups = [aws_security_group.ecs_sg.id]
}
}
