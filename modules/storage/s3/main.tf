# generates random pet names that are intended to be used as unique identifiers for other resources
resource "random_pet" "bucket_name" {
  length = 2
}

resource "aws_s3_bucket" "static_content_bucket" {       # the bucket name must be unique therefore adding random-pet
  bucket = "static-content-${random_pet.bucket_name.id}" 
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

# giving permisions to make the bucket public 
resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.static_content_bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}