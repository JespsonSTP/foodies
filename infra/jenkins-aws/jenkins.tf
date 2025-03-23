resource "aws_iam_instance_profile" "jenkins_server_profile" {
  name = "jenkins_server_profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_instance" "jenkins_web" {
  ami           = "ami-0ccd80bd9203e03d1"
  instance_type = "t3.medium"
  key_name = "mynewkey"
  security_groups = [ aws_security_group.jenkinsserver.id ]
  subnet_id = aws_subnet.priv_sub1.id

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 40
    delete_on_termination = false
  }

  iam_instance_profile = aws_iam_instance_profile.jenkins_server_profile.name

   metadata_options {
    http_tokens               = "required"       # Enforces IMDSv2 usage
    http_endpoint             = "enabled"        # Enable metadata service
    http_put_response_hop_limit = 3              # Set hop limit (default is 1)
  }

  tags = {
    Name = "Jenkins-Foodies-web"
  }

  lifecycle {
    #ignore_changes = all
    #prevent_destroy = true
  }

  depends_on = [ aws_iam_role_policy_attachment.jenkins_policy ]
}