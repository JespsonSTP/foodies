# Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.jenks-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [ aws_vpc.jenks-vpc ]
}

resource "aws_security_group" "elb_jenkins_sg" {
    name        = "elb_jenkins_sg"
    description = "Allow http traffic"
    vpc_id      = aws_vpc.jenks-vpc.id
  
    ingress {
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
      from_port   = "8080"
      to_port     = "8080"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port   = "9000"
      to_port     = "9000"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name   = "elb_jenkins_sg"
    }
}

# Security Group for jenkinsserver Host
resource "aws_security_group" "jenkinsserver" {
  name        = "jenkinsserver-sg"
  description = "jenkinsserver security group"
  vpc_id      = aws_vpc.jenks-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups= [aws_security_group.bastion_sg.id] 
  }

  ingress {
    from_port       = "8080"
    to_port         = "8080"
    protocol        = "tcp"
    cidr_blocks     = [var.jenkins_cidr_block]
  }
  ingress {
    from_port       = "9000"
    to_port         = "9000"
    protocol        = "tcp"
    cidr_blocks     = [var.jenkins_cidr_block]
  }

  ingress {
    from_port       = "8080"
    to_port         = "8080"
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_jenkins_sg.id]
}
  ingress {
    from_port       = "9000"
    to_port         = "9000"
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_jenkins_sg.id]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [ aws_security_group.bastion_sg ]
}

resource "aws_security_group" "jenkinsworker" {
  name        = "jenkinsworker"
  description = "jenkinsworker security group"
  vpc_id      = aws_vpc.jenks-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups= [aws_security_group.bastion_sg.id, aws_security_group.jenkinsserver.id] 
  }

  ingress {
    from_port        = 4243
    to_port          = 4243
    protocol         = "tcp"
    security_groups  = [aws_security_group.jenkinsserver.id] 
  }

  ingress {
    from_port       = "32768"
    to_port         = "60999"
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkinsserver.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [ aws_security_group.bastion_sg ]
}
