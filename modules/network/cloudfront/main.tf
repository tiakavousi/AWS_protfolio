resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  comment             = "S3 Bucket CloudFront Distribution"
  default_root_object = "picture_bucket"

  origin {
    domain_name = var.domain_name
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = ""
    }
  }
  
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}