resource "azurerm_virtual_network" "hub_vnet" {
  name                = "hub-vnet"
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  address_space       = ["10.0.0.0/16"]  # Adjust as needed
}

