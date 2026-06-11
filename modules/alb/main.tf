resource "aws_lb" "alb" {

name               = "${var.project_name}-alb"
load_balancer_type = "application"

security_groups = [
var.alb_sg
]

subnets = [
var.public_subnet_a,
var.public_subnet_b
]

tags = {
Environment = var.environment
Project     = var.project_name
}
}

resource "aws_lb_target_group" "ecs_tg" {

name        = "${var.project_name}-tg"
port        = 3000
protocol    = "HTTP"
target_type = "ip"

vpc_id = var.vpc_id

health_check {
enabled = true
path    = "/api/health"
}
}

resource "aws_lb_listener" "https" {

load_balancer_arn = aws_lb.alb.arn

port     = 443
protocol = "HTTPS"

certificate_arn = var.certificate_arn

default_action {


type = "forward"

target_group_arn = aws_lb_target_group.ecs_tg.arn


}
}
