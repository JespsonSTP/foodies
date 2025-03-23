data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs_random = data.aws_availability_zones.available.names

  subnet_definitions = {
    public = {
      "subnet1" = {
        cidr_block        = var.public_subnet_cidrs[0]
        availability_zone = local.azs_random[0]
      }
      "subnet2" = {
        cidr_block        = var.public_subnet_cidrs[1]
        availability_zone = local.azs_random[1]
      }
      "subnet3" = {
        cidr_block        = var.public_subnet_cidrs[2]
        availability_zone = local.azs_random[2]
      }
    }
    private = {
      "subnet1" = {
        cidr_block        = var.private_subnet_cidrs[0]
        availability_zone = local.azs_random[0]
      }
      "subnet2" = {
        cidr_block        = var.private_subnet_cidrs[1]
        availability_zone = local.azs_random[1]
      }
      "subnet3" = {
        cidr_block        = var.private_subnet_cidrs[2]
        availability_zone = local.azs_random[2]
      }
    }
    eks = {
      "subnet1" = {
        cidr_block        = var.eks_subnet_cidrs[0]
        availability_zone = local.azs_random[0]
      }
      "subnet2" = {
        cidr_block        = var.eks_subnet_cidrs[1]
        availability_zone = local.azs_random[1]
      }
      "subnet3" = {
        cidr_block        = var.eks_subnet_cidrs[2]
        availability_zone = local.azs_random[2]
      }
    }
  }
}


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-network"
    application = var.application_name
    environment = var.environment_name
  }
}

#internet gatewsy

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.application_name}-${var.environment_name}-igw"
    application = var.application_name
    environment = var.environment_name
  }
}

resource "aws_eip" "nateip" {
  domain   = "vpc"
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nateip.id
  subnet_id     = values(aws_subnet.pub_sub)[0].id

  tags = {
    Name = "foodies-prod-eks-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#public aws_subnets
resource "aws_subnet" "pub_sub" {

  for_each = local.subnet_definitions.public
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name                           = "Public Subnet ${each.key}"
    "kubernetes.io/cluster/foodies-eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }

}

resource "aws_subnet" "priv_sub" {

  for_each = local.subnet_definitions.private
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  map_public_ip_on_launch = false

}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "privateRT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }
}

resource "aws_route_table_association" "pub_sub_rt" {
  for_each = aws_subnet.pub_sub
  subnet_id      = each.value.id
  route_table_id = aws_route_table.publicRT.id
}


resource "aws_route_table_association" "priv_sub_rt" {
  for_each = aws_subnet.priv_sub
  subnet_id      = each.value.id
  route_table_id = aws_route_table.privateRT.id
}





