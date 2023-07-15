resource "aws_s3_bucket" "querocodar_bucket" {
  bucket = "querocodar.com.br"
}

resource "aws_s3_bucket_website_configuration" "querocodar_config" {
  bucket = aws_s3_bucket.querocodar_bucket.bucket
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "querocodar_ownership_controls" {
  bucket = aws_s3_bucket.querocodar_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "querocodar_access_block" {
  bucket                  = aws_s3_bucket.querocodar_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "querocodar_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.querocodar_ownership_controls,
    aws_s3_bucket_public_access_block.querocodar_access_block,
  ]
  bucket = aws_s3_bucket.querocodar_bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "querocodar_index" {
  bucket       = aws_s3_bucket.querocodar_bucket.id
  key          = "index.html"
  source       = "../src/index.html"
  acl          = "public-read"
  content_type = "text/html"
}
