#resource "aws_autoscaling_group" "asg_jenkinsfleet" {
  # launch_configuration  = "${aws_launch_configuration.as_lc_node_app.name}"
  # depends_on            = [aws_alb_target_group.node_tg]
  #health_check_type     = "ELB"
  #target_group_arns     = ["${aws_alb_target_group.node_tg.arn}"]
#  vpc_zone_identifier   = ["${aws_subnet.priv_sub2.id}","${aws_subnet.priv_sub1.id}"]
#  min_size              = 1
#  max_size              = 4 
#  desired_capacity      = 1 

#  launch_template {
#    id      = aws_launch_template.jenkinsagentsfleet.id
#  }
#}