terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  backend "s3" {
    bucket         = "dataplatformterraform-backend" 
    key            = "dataplatformterraform-backend/terraform.tfstate"                   
    dynamodb_table = "dataplatform-table"
    region         = "us-east-2"  
    encrypt        = true    
  }                    
}
