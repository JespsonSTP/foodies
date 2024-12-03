output "vpc_id" {
  value = aws_vpc.main.id
}

output "server_subnet" {
  value = aws_subnet.priv_sub1.id
}

output "bastion_public_ip" {
  value = aws_instance.Bastion.public_ip
}