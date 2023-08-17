resource "random_pet" "bucket_name" {
  length = 2
}

resource "aws_s3_bucket" "static_content_bucket" {
  bucket = "static-content-${random_pet.bucket_name.id}"
}

resource "aws_s3_bucket_website_configuration" "static_content" {
  bucket = aws_s3_bucket.static_content_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "static_content" {
  bucket = aws_s3_bucket.static_content_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Uploading "index.html"
resource "aws_s3_bucket_object" "bucket_index_html" {
  bucket = aws_s3_bucket.static_content_bucket.bucket
  key    = "index.html"
  source = "${path.module}/../../../static_contents/index.html"
  etag   = filemd5("${path.module}/../../../static_contents/index.html")
}

# Uploading "error.html"
resource "aws_s3_bucket_object" "bucket_error_html" {
  bucket = aws_s3_bucket.static_content_bucket.bucket
  key    = "error.html"
  source = "${path.module}/../../../static_contents/error.html"
  etag   = filemd5("${path.module}/../../../static_contents/error.html")
}
