/*
.25 vCPU - 0.5 GB, 1 GB, 2 GB
.5 vCPU  - 1 GB, 2 GB, 3 GB, 4 GB
1 vCPU   - 2 GB, 3 GB, 4 GB, 5 GB, 6 GB, 7 GB, 8 GB
2 vCPU   - Between 4 GB and 16 GB in 1-GB increments
4 vCPU   - Between 8 GB and 30 GB in 1-GB increments
*/

#############
# VPC
#############
variable "cidr" {}

variable "target_env" {
  description = "default target environment"
}


variable "target_region" {
  description = "default target region"
}

variable "target_domain" {
  description = "default target domain name"
}

variable "target_zone" {
  description = "default target zone name"
}
variable "infra_ecr" {
  description = "default infra ecr"
}

variable "backend_oci_name" {
  description = "default backend name"
}

variable "backend_oci_tag" {
  description = "default backend tag"
}

#############
# AUDIT
#############

variable "cloudfront_logging" {
  # Not all regions support cloudfront logging to s3
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html
  type        = bool
  default     = true
  description = "if enabled cloudfront access logging will be enabled."
}

variable "target_stag_domain" {
  description = "default target domain name"
  default = "stag.tranphong134.vn"
}

variable "target_stag_env" {
  description = "default target environment"
  default = "stag"
}