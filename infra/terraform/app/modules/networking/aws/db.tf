resource "aws_db_instance" "postgres" {
  db_name              = "myfoodiesatmdb"
  identifier = "myfoodiesatmdb"
  engine               = "postgres"
  engine_version       = "16"
  instance_class       = "db.t4g.micro"
  username             = "foo"
  password             = "foobarbaz"
  skip_final_snapshot  = true
  multi_az                    = false
  storage_type               = "gp3"
  engine_lifecycle_support = "open-source-rds-extended-support-disabled"
  db_subnet_group_name = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = ["${aws_security_group.privatm.id}"]
  allocated_storage     = 20
  max_allocated_storage = 30
  tags = {
    Name = "myfoodiesatmdb"
  }

  depends_on = [ aws_db_subnet_group.postgres ]
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres"
  subnet_ids = ["${aws_subnet.db_sub1.id}","${aws_subnet.db_sub2.id}"]
  tags = {
    Name = "My DB subnet group"
  }

  depends_on = [ aws_subnet.priv_sub1, aws_subnet.priv_sub2 ]
}



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


