terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "foodies"
    storage_account_name = "foodiesterraformbackend"
    container_name = "networktfstate"
    key = "terraform.tfstate"
  }
}


