resource "aws_s3_bucket" "frontend" {
bucket = "${var.project_name}-frontend-bucket"
}

resource "aws_s3_bucket_public_access_block" "frontend" {
bucket = aws_s3_bucket.frontend.id

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_control" "oac" {
name                              = "frontend-oac"
description                       = "CloudFront OAC"
origin_access_control_origin_type = "s3"
signing_behavior                  = "always"
signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "frontend_policy" {

bucket = aws_s3_bucket.frontend.id

policy = jsonencode({

Version = "2012-10-17"

Statement = [
  {
    Sid = "AllowCloudFrontRead"

    Effect = "Allow"

    Principal = {
      Service = "cloudfront.amazonaws.com"
    }

    Action = [
      "s3:GetObject"
    ]

    Resource = [
      "${aws_s3_bucket.frontend.arn}/*"
    ]
  }
]

})
}

