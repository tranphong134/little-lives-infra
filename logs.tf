resource "aws_s3_bucket" "logs" {
  tags   = merge(local.common_tags, { Product = "${var.target_domain}-logs" })
  bucket = "${var.target_domain}-logs"
}
resource "aws_s3_bucket" "stag-logs" {
  tags   = merge(local.common_tags, { Product = "${var.target_stag_domain}-logs" })
  bucket = "${var.target_stag_domain}-logs"
}