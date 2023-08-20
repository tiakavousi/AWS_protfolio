resource "random_pet" "bucket_name" { # generates random pet names that are intended to be used as unique identifiers for other resources.
  length = 3
}

resource "aws_s3_bucket" "static_content_bucket" {
  bucket = "static-content-${random_pet.bucket_name.id}" // the bucket name must be unique therefore adding random-pet
  
  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_bucket_website_configuration" "static_content" {
  bucket = aws_s3_bucket.static_content_bucket.id

  index_document {
    suffix = "picture_bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "static_content" {
  bucket = aws_s3_bucket.static_content_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Uploading Images
resource "aws_s3_bucket_object" "picture_bucket" {
  bucket = aws_s3_bucket.static_content_bucket.bucket
  key    = "geek.jpeg"
  source = "${path.module}/static_contents/geek.jpeg"
  etag   = filemd5("${path.module}/static_contents/geek.jpeg")
  acl    = "public-read"
}
resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.static_content_bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}