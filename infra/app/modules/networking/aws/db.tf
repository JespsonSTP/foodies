# Security Group for Bastion Host
resource "aws_security_group" "privatm" {
  name        = "privpostgres"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    security_groups= [aws_security_group.bastion_sg.id] 
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups= [aws_security_group.bastion_sg.id] 
  }
  
  ingress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups= [aws_security_group.bastion_sg.id] 
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


