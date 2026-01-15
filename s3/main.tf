resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
#   acl    = "public-read"

#   website {
#     index_document = "index.html"
#     error_document = "error.html"
#   }
}


resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_distribution_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
