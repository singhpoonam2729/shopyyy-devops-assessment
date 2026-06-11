resource "random_password" "db_password" {
length  = 16
special = true
}

resource "aws_secretsmanager_secret" "db_secret" {
name = "${var.project_name}-db-secret"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {

secret_id = aws_secretsmanager_secret.db_secret.id

secret_string = jsonencode({
username = "admin"
password = random_password.db_password.result
})
}

resource "aws_db_subnet_group" "db_subnet_group" {

name = "${var.project_name}-db-subnet-group"

subnet_ids = [
var.private_subnet_a,
var.private_subnet_b
]
}

resource "aws_db_instance" "postgres" {

identifier = "${var.project_name}-postgres"

engine         = "postgres"
engine_version = "17"

instance_class = "db.t3.medium"

allocated_storage = 20

multi_az = true

publicly_accessible = false

username = "admin"

password = random_password.db_password.result

db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

vpc_security_group_ids = [
var.rds_sg
]

skip_final_snapshot = true
}
