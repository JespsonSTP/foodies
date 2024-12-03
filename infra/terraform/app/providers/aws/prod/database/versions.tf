terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  backend "s3" {
    bucket         = "myfoodiesrdspostgres" 
    key            = "myfoodiesrdspostgres/terraform.tfstate"                   
    dynamodb_table = "foodiesrdspostgres-table"
    region         = "us-east-2"  
    encrypt        = true    
  }                    
}