# Delegate oci tag deployments to external system
# ignore_oci_tag_changes = true

# Networking
cidr                = "172.29"

# dev tranphong134 specific vars
target_env          = "dev"
target_domain       = "dev.tranphong134.vn"
target_region       = "ap-southeast-1"
target_zone         = "tranphong134.vn"


infra_ecr = "318150370907.dkr.ecr.ap-southeast-1.amazonaws.com"


# ecr backend
backend_oci_name="tranphong134-backend"
backend_oci_tag="dev-latest"
