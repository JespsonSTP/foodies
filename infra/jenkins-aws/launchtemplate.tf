resource "aws_launch_template" "jenkinsmain" {
  name = "jenkinsmain"

  image_id = "ami-04492f07263f4a9df"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "mynewkey"


  monitoring {
    enabled = true
  }


  vpc_security_group_ids = ["${aws_security_group.jenkinsserver.id}"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "jenkinsmain"
    }
  }
}


#resource "aws_launch_template" "jenkinsagentsfleet" {
#  name = "jenkinsagentsfleet"

#  block_device_mappings {
#   device_name = "/dev/sdf"

#    ebs {
#      volume_size = 20
#      delete_on_termination = true
#      encrypted  = true
#    }
#  }

#  ebs_optimized = true

#  image_id = "ami-04492f07263f4a9df"

#  instance_initiated_shutdown_behavior = "terminate"

#  instance_type = "t2.micro"

#  key_name = "jenkinsfleet"


#  monitoring {
#    enabled = true
#  }
#  vpc_security_group_ids = ["${aws_security_group.jenkinsworker.id}"]

#  tag_specifications {
#    resource_type = "instance"

#    tags = {
#     Name = "jenkinsagent"
#    }
# }

#}