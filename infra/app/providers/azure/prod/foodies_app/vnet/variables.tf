variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "postgres-rg"
}

variable "vm_size" {
  default = "Standard_D2s_v3"
}

variable "admin_username" {
  default = "azureuser"
}

variable "admin_password" {
  default = "YourSecurePassword!" # Replace with a secure password
}
