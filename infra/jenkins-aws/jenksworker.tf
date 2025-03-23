#resource "aws_instance" "jenksworker" {
#  ami           = "ami-04deb2824a91c3776"
#  instance_type = "t3.micro"
#  key_name = "mynewkey"
#  security_groups = [ aws_security_group.dockerhost.id ]
 # subnet_id = aws_subnet.priv_sub1.id

  #root_block_device {
   # volume_type           = "gp3"
    #volume_size           = 30
   # delete_on_termination = false
  #}

  #tags = {
   # Name = "jenksworker-Foodies"
  #}

  #lifecycle {
  #  #ignore_changes = all
  #  #prevent_destroy = true
  #}
#}