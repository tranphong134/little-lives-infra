terraform {
 backend "s3" {
   bucket         = "terraform-state-tranphong134"
   key            = "dev/tranphong134.tfstate"
   region         = "ap-southeast-1"
   encrypt        = true
 }
}