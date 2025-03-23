resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "foodiesprodaks"

  kubernetes_version = "1.29"
  private_cluster_enabled = false

  # For production change to "Standard" 
  sku_tier = "Free"

  #oidc_issuer_enabled = true
  #workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.64.10"
    service_cidr   = "10.0.64.0/19"
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    min_count = 1
    max_count = 3
    auto_scaling_enabled = true
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.newsubnet1.id
    node_labels = {
        role = "foodieseksworkers"
    }

  }

  identity {
        type = "SystemAssigned"
  }

  #identity {
  #  type = "UserAssigned"
  #  identity_ids = [azurerm_user_assigned_identity.base.id]
  #}

  lifecycle {
     ignore_changes = [ default_node_pool[0].node_count ]
  #  #ignore_changes = all
  #  #prevent_destroy = true
  }

  tags = {
    Environment = "Production"
  }
}



