data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "Bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "mynewkey"
  security_groups = [ aws_security_group.bastion_sg.id ]
  subnet_id = aws_subnet.pub_sub1.id

  tags = {
    Name = "Bastion"
  }

  lifecycle {
    #ignore_changes = all
    #prevent_destroy = true
  }

  depends_on = [ aws_security_group.bastion_sg ]
}