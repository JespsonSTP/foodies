terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "prodimpresso"
    storage_account_name = "prodimpressostorage"
    container_name       = "networking"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

//terraform import azurerm_resource_group.MyResourceGroup /subscriptions/MySubscriptionNumber/resourceGroups/MyResourceGroup
//terraform import azurerm_resource_group.prodimpresso /subscriptions/689e98b7-10f0-470a-9084-0eb791f7833a/resourceGroups/prodimpresso

resource "azurerm_resource_group" "prodimpresso" {
  name = "prodimpresso"
  location = "switzerlandnorth"

  tags = {
    environment = "PROD"
  }
}

module "networking" {
  source = "../modules/networking"
  azurerm_resource_group_name = azurerm_resource_group.prodimpresso.name
  azurerm_resource_group_location = azurerm_resource_group.prodimpresso.location
}

