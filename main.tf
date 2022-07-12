data "aws_region" "current" {}

data "aws_partition" "current" {}

data "aws_availability_zones" "current" {}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "tranphong134" {
  name         = var.target_zone
  private_zone = false
}
