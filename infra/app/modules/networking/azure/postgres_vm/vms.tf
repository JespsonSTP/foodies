resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = "postgres-vmss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = "azureuser"
  disable_password_authentication = true

  network_interface {
    name                      = "postgres-nic"
    primary                   = true
    subnet_id                 = azurerm_subnet.subnet.id
    load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool.id]
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'YourSecurePassword';"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '10.0.1.0'/g" /etc/postgresql/12/main/postgresql.conf
echo "host all all 10.0.0.0/16 md5" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf
sudo systemctl restart postgresql
EOF
  )
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  name                = "postgres-autoscale"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "default"

    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        operator           = "GreaterThan"
        threshold          = 70
        time_grain         = "PT1M"
        statistic          = "Average"
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }
    }
  }
}