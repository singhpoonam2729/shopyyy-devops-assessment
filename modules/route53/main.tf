resource "aws_route53_zone" "main" {
name = "shopyyy.com"
}
resource "aws_route53_record" "root" {

zone_id = aws_route53_zone.main.zone_id

name = "shopyyy.com"

type = "A"

alias {


name = var.cloudfront_domain

zone_id = var.cloudfront_zone_id

evaluate_target_health = false

}
}
