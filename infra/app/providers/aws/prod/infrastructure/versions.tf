terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  backend "s3" {
    bucket         = "myfoodiesinfra" 
    key            = "myfoodiesinfra/terraform.tfstate"                   
    dynamodb_table = "foodiesinfra-table"
    region         = "us-east-2"  
    encrypt        = true    
  }                    
}