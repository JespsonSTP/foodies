resource "aws_instance" "jenkins_web" {
  ami           = "ami-096f0ab1f06479d08"
  instance_type = "t3.micro"
  key_name = "mynewkey"
  security_groups = [ aws_security_group.jenkinsserver.id ]
  subnet_id = aws_subnet.priv_sub1.id

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    delete_on_termination = false
  }

  tags = {
    Name = "Jenkins-Foodies-web"
  }

  lifecycle {
    #ignore_changes = all
    #prevent_destroy = true
  }
}