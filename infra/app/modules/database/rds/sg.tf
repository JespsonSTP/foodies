resource "aws_security_group" "privatm" {
    name        = "privpostgres"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-04d9d1d5e81609c75"
}


resource "aws_security_group_rule" "priv_postgresql_access" {
  type        = "ingress"
  from_port    = 5432
  to_port      = 5432
  protocol     = "tcp"
  security_group_id = aws_security_group.privatm.id
  description  = "PostgreSQL access from a specific IP"
  cidr_blocks  = ["10.0.0.0/16"]
}