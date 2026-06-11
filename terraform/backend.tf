terraform {
backend "s3" {
bucket = "shopyyy-terraform-state"
key    = "prod/terraform.tfstate"
region = "ap-south-1"
}
}
