resource "aws_elasticache_subnet_group" "redis_subnet_group" {

name = "${var.project_name}-redis-subnet-group"

subnet_ids = [
var.private_subnet_a,
var.private_subnet_b
]
}

resource "aws_elasticache_cluster" "redis" {

cluster_id = "${var.project_name}-redis"

engine = "redis"

node_type = "cache.t3.micro"

num_cache_nodes = 1

port = 6379

subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name

security_group_ids = [
var.redis_sg
]
}
