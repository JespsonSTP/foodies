terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  backend "s3" {
    bucket         = "myfoodiesjenkins" 
    key            = "myfoodiesjenkins/terraform.tfstate"                   
    dynamodb_table = "foodiesjenkins-table"
    region         = "us-east-2"  
    encrypt        = true    
  }                    
}
