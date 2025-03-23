resource "aws_lb" "example" {
  name               = "foodies-jenkins-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_jenkins_sg.id]
  subnets            = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id] //different azs please
}

resource "aws_lb_target_group" "example_8080" {
  name     = "example-target-group-8080"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.jenks-vpc.id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    port                = "8080"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "example_9000" {
  name     = "example-target-group-9090"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = aws_vpc.jenks-vpc.id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    port                = "9000"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

# Listener for port 8080
resource "aws_lb_listener" "listener_8080" {
  load_balancer_arn = aws_lb.example.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_8080.arn
  }
}

# Listener for port 9000
resource "aws_lb_listener" "listener_9000" {
  load_balancer_arn = aws_lb.example.arn
  port              = 9000
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_9000.arn
  }
}



# Register the EC2 instance to the first target group (port 8080)
resource "aws_lb_target_group_attachment" "example_attachment_8080" {
  target_group_arn = aws_lb_target_group.example_8080.arn
  target_id        = aws_instance.jenkins_web.id
  port             = 8080
}

# Register the EC2 instance to the second target group (port 9000)
resource "aws_lb_target_group_attachment" "example_attachment_9000" {
  target_group_arn = aws_lb_target_group.example_9000.arn
  target_id        = aws_instance.jenkins_web.id
  port             = 9000
}