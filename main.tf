module "s3" {
  source = "./s3"
  bucket_name = var.bucket_name
  env = var.env 
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}

module "cloudfront" {
  source = "./cloudfront"
  acm_certificate_arn = var.acm_certificate_arn
  bucket_name = module.s3.s3_bucket_name
  env = var.env 
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}

module "route53" {
  source = "./route53"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = var.cloudfront_hosted_zone_id
  domain_name = var.domain_name
  hosted_zone_id = var.hosted_zone_id
}