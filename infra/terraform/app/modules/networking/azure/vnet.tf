resource "azurerm_network_security_group" "sgexample" {
  name                = "example-security-group"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
}


resource "azurerm_virtual_network" "vnetexample" {
  name                = "example-network"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.sgexample.id
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_subnet" "bastion" {
  name = "bastionsubnet"
  address_prefixes = ["10.0.3.0/24"]
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnetexample.name
  
}

