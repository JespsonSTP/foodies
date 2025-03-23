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

  tags = {
    environment = "Production-aks-foodies"
  }
}


resource "azurerm_subnet" "newsubnet1" {
  name                 = "newsubnet1"
  address_prefixes     = ["10.0.0.0/19"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnetexample.name
}

resource "azurerm_subnet" "newsubnet2" {
  name                 = "newsubnet2"
  address_prefixes     = ["10.0.32.0/19"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnetexample.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "postgres-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
