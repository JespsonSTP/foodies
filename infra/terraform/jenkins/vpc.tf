data "aws_availability_zones" "availzones" {}

resource "aws_vpc" "jenks-vpc" {
  cidr_block = var.jenkins_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.jenkins_vpc
  }
}


resource "aws_internet_gateway" "jenkinsigw" {
  vpc_id = aws_vpc.jenks-vpc.id

  tags = {
    Name = "${var.jenkins_vpc}-igw"
  }
}



resource "aws_eip" "jenksnateip" {

    tags = {
        Name = "${var.jenkins_vpc}-eip"
    }
  
}


#public aws_subnets

resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.jenks-vpc.id
  cidr_block = "192.168.2.0/28"
  availability_zone = data.aws_availability_zones.availzones.names[0]
  map_public_ip_on_launch = true

  tags = {
  }

}

resource "aws_subnet" "pub_sub2" {
  vpc_id     = aws_vpc.jenks-vpc.id
  cidr_block = "192.168.2.16/28"
  availability_zone = data.aws_availability_zones.availzones.names[1]
  map_public_ip_on_launch = true

  tags = {
  }
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.jenks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkinsigw.id
  }

  # Ignore changes to routes
  lifecycle {
    ignore_changes = [route]
  }
}

resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.jenks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.jenkinsnat.id
  }

  # Ignore changes to routes
  lifecycle {
    ignore_changes = [route]
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.publicRT.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.publicRT.id
}



resource "aws_nat_gateway" "jenkinsnat" {
    allocation_id = aws_eip.jenksnateip.id
    subnet_id = aws_subnet.pub_sub1.id
    tags = {
      Name = "${var.jenkins_vpc}-nat"
    }
  
}


