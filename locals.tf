locals {
  environment = var.target_env
  account     = "tranphong134@gmail.com"
  common_tags = {
    Environment = local.environment
    Terraform   = "true"
    SourceRepo  = "git@github.com:tranphong134/little-lives-infra.git"
    DeployedBy  = local.account
    Owner       = "tranphong134"
    Team        = "tranphong134@gmail.com"
  }
}
