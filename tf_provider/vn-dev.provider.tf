provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "cloudfront_cert_region"
  region = "us-east-1"
}

provider "aws" {
  alias  = "alb_cert_region"
  region = "ap-southeast-1"
}
