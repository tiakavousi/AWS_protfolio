output "cloudfront_distribution_dns" {
  description = "The domain name (DNS) of the CloudFront distribution."
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}