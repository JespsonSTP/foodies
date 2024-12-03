resource "azurerm_kubernetes_cluster" "name" {
  name = "foodies"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix = "prodaks1"

  kubernetes_version = 
  automatic_upgrade_channel = "Stable"
  private_cluster_enabled = false
  node_resource_group = 


  sku_tier = "Free"

  oidc_issuer_enabled = 
}