resource "aws_subnet" "eks_sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.7.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  
  tags = {
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

}
resource "aws_subnet" "eks_sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.8.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}


resource "aws_route_table_association" "ekssub_association1" {
  subnet_id      = aws_subnet.eks_sub1.id
  route_table_id = aws_route_table.privateRT.id
}

resource "aws_route_table_association" "ekssub_association2" {
  subnet_id      = aws_subnet.eks_sub2.id
  route_table_id = aws_route_table.privateRT.id
}
