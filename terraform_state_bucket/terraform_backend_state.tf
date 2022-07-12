resource "aws_s3_bucket" "terraform-state" {
  tags          = local.common_tags
  bucket        = "terraform-state-tranphong134"
  # acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "terraform-state-acl" {
  bucket = aws_s3_bucket.terraform-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform-state_versioning" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}