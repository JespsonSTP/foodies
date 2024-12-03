output "vpc_id" {
  value = module.networking.vpc_id
}

output "server_subnet" {
  value = module.networking.server_subnet
}

output "bastion_public_ip" {
  value = module.networking.bastion_public_ip
}