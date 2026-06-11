module "vpc" {
source = "./modules/vpc"

project_name          = var.project_name
environment           = var.environment

vpc_cidr              = var.vpc_cidr

public_subnet_a_cidr  = var.public_subnet_a_cidr
public_subnet_b_cidr  = var.public_subnet_b_cidr

private_subnet_a_cidr = var.private_subnet_a_cidr
private_subnet_b_cidr = var.private_subnet_b_cidr
}
module "security_groups" {
source = "./modules/security-groups"

vpc_id       = module.vpc.vpc_id
project_name = var.project_name
environment  = var.environment
}

module "s3" {
source = "./modules/s3"

project_name = var.project_name
}

module "route53" {
source = "./modules/route53"
}

module "acm" {
source = "./modules/acm"

zone_id = module.route53.zone_id
}

module "alb" {

source = "./modules/alb"

project_name = var.project_name
environment  = var.environment

vpc_id = module.vpc.vpc_id

public_subnet_a = module.vpc.public_subnet_a
public_subnet_b = module.vpc.public_subnet_b

alb_sg = module.security_groups.alb_sg

certificate_arn = module.acm.certificate_arn
}

module "ecs" {

source = "./modules/ecs"

project_name = var.project_name
environment  = var.environment

private_subnet_a = module.vpc.private_subnet_a
private_subnet_b = module.vpc.private_subnet_b

ecs_sg = module.security_groups.ecs_sg

target_group_arn = module.alb.target_group_arn

database_url = "placeholder"
redis_url    = "placeholder"
}

module "rds" {

source = "./modules/rds"

project_name = var.project_name
environment  = var.environment

private_subnet_a = module.vpc.private_subnet_a
private_subnet_b = module.vpc.private_subnet_b

rds_sg = module.security_groups.rds_sg
}

module "redis" {

source = "./modules/redis"

project_name = var.project_name

private_subnet_a = module.vpc.private_subnet_a
private_subnet_b = module.vpc.private_subnet_b

redis_sg = module.security_groups.redis_sg
}

module "msk" {

source = "./modules/msk"

project_name = var.project_name

private_subnet_a = module.vpc.private_subnet_a
private_subnet_b = module.vpc.private_subnet_b

msk_sg = module.security_groups.msk_sg
}

module "cloudfront" {

source = "./modules/cloudfront"

bucket_domain = module.s3.bucket_domain

alb_dns = module.alb.alb_dns

certificate_arn = module.acm.certificate_arn

oac_id = module.s3.oac_id
}
