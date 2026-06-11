output "bucket_name" {
value = aws_s3_bucket.frontend.id
}

output "bucket_domain" {
value = aws_s3_bucket.frontend.bucket_regional_domain_name
}

output "oac_id" {
value = aws_cloudfront_origin_access_control.oac.id
}
