# Shopyyy AWS Infrastructure

This project provisions a production-style AWS infrastructure using Terraform.

## Services Used

* VPC
* Route53
* ACM
* CloudFront
* S3
* Application Load Balancer
* ECS Fargate
* PostgreSQL RDS
* ElastiCache Redis
* Amazon MSK
* Secrets Manager

## Architecture

Users
→ Route53
→ CloudFront

Frontend:
CloudFront → S3

Backend:
CloudFront → ALB → ECS

Database:
ECS → PostgreSQL

Caching:
ECS → Redis

Messaging:
ECS → Kafka (MSK)
→ Worker Service

## Deployment

terraform init

terraform plan

terraform apply

## Outputs

CloudFront Domain

ALB DNS

RDS Endpoint

Redis Endpoint

MSK Bootstrap Brokers

# Architecture Diagram: https://drive.google.com/file/d/1YQTjRivgYFHOEPnwvabhAEVda-Shjdlk/view?usp=sharing
