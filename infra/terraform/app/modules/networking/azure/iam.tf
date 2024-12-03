resource "random_id" "log_analytics" {
  byte_length = 8
}

resource "azurerm_user_assigned_identity" "name" {
  name = "base"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "name" {
  scope = var.resource_group_name.id
  role_definition_name = "Network Contributor"
  principal_id = azurerm_user_assigned_identity.name.principal_id
}

