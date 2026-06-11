output "cloudfront_domain" {
value = module.cloudfront.cloudfront_domain
}

output "alb_dns" {
value = module.alb.alb_dns
}

output "rds_endpoint" {
value = module.rds.rds_endpoint
}

output "redis_endpoint" {
value = module.redis.redis_endpoint
}

output "msk_bootstrap_servers" {
value = module.msk.bootstrap_brokers
}
