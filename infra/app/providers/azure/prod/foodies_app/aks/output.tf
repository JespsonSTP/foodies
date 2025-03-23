output "client_certificate" {
  value     = module.networking.client_certificate
  sensitive = true
}

output "kube_config" {
  value = module.networking.kube_config

  sensitive = true
}

