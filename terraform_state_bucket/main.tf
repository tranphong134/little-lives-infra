locals {
  common_tags = {
    maintainer  = "tranphong134@gmail.com",
    terraform   = "git@github.com:tranphong134/little-lives-infra.git",
    region      = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}
