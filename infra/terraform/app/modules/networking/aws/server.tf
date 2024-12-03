resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "mynewkey"
  security_groups = [ aws_security_group.testserver.id ]
  subnet_id = aws_subnet.priv_sub1.id

  tags = {
    Name = "web"
  }
}