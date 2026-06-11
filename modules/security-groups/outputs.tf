output "alb_sg" {
value = aws_security_group.alb_sg.id
}

output "ecs_sg" {
value = aws_security_group.ecs_sg.id
}

output "rds_sg" {
value = aws_security_group.rds_sg.id
}

output "redis_sg" {
value = aws_security_group.redis_sg.id
}

output "msk_sg" {
value = aws_security_group.msk_sg.id
}
