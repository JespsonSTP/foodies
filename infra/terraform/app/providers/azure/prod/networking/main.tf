data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}


module "networking" {
  source = "../../../../modules/networking/azure"
  #resource_group_name = data.resource_group_name.name
}