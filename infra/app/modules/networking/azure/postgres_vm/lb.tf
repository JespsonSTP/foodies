resource "azurerm_lb" "internal_lb" {
  name                = "postgres-internal-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "postgres-internal-frontend"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.internal_lb.id
  name            = "postgres-backend-pool"
}

resource "azurerm_lb_probe" "postgres_probe" {
  loadbalancer_id = azurerm_lb.internal_lb.id
  name            = "postgres-health-probe"
  protocol        = "Tcp"
  port            = 5432
  interval_in_seconds = 10
  number_of_probes    = 3
}

resource "azurerm_lb_rule" "postgres_rule" {
  loadbalancer_id                = azurerm_lb.internal_lb.id
  name                            = "postgres-rule"
  protocol                        = "Tcp"
  frontend_port                   = 5432
  backend_port                    = 5432
  frontend_ip_configuration_name  = "postgres-internal-frontend"
  backend_address_pool_id         = azurerm_lb_backend_address_pool.backend_pool.id
  probe_id                        = azurerm_lb_probe.postgres_probe.id
}
