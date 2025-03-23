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
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres"
  subnet_ids = ["subnet-0d854538a83f6e999","subnet-0128e000a94565d74"]
  tags = {
    Name = "My DB subnet group"
  }
}