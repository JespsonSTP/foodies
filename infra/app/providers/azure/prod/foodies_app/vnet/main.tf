resource "azurerm_resource_group" "foodies" {
  name     = "foodies"
  location = "eastus"
}

#write the resource code first
#import the resource
#terraform import azurerm_resource_group.foodies /subscriptions/37a100d8-ab33-48be-becf-5cbed5b9c0de/resourceGroups/foodies



module "networking" {
  source = "../../../../../modules/networking/azure/foodies_vnet"
  resource_group_name = azurerm_resource_group.foodies.name
  resource_group_location = azurerm_resource_group.foodies.location
  resource_group_id = azurerm_resource_group.foodies.id
}
module "postgres_db" {
  source = "../../../../../modules/networking/azure/postgres_vm"
  resource_group_name = azurerm_resource_group.foodies.name
  resource_group_location = azurerm_resource_group.foodies.location
  resource_group_id = azurerm_resource_group.foodies.id
}

