resource "aws_s3_bucket" "dbt_docs" {
  bucket = "${var.env}-${var.app_name}-docs-static"
}

resource "aws_s3_bucket_policy" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id
  policy = jsonencode(
    {
      Id      = "PolicyForCloudFrontPrivateContent"
      Version = "2008-10-17"
      Statement = [
        {
          Action = "s3:GetObject"
          Condition = {
            StringEquals = {
              "AWS:SourceArn" = "${aws_cloudfront_distribution.main.arn}"
            }
          }
          Effect = "Allow"
          Principal = {
            Service = "cloudfront.amazonaws.com"
          }
          Resource = "${aws_s3_bucket.dbt_docs.arn}/*"
          Sid      = "AllowCloudFrontServicePrincipal"
        },
      ]
    }
  )
}

resource "aws_s3_bucket_public_access_block" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id

  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id

  index_document {
    suffix = "index.html"
  }
}
