output "s3_bucket_name" {
  value = aws_s3_bucket.website_bucket.id
}

output "s3_website_url" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}