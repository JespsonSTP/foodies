data "terraform_remote_state" "vpc" {
 backend     = "s3"

 config = {
   bucket = "foodiesinfra"
   key    = "foodiesinfra/terraform.tfstate"
   region = "us-east-2"
 }
}


