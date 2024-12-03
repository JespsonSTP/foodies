resource "aws_subnet" "priv_sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
}

resource "aws_subnet" "priv_sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.priv_sub1.id
  route_table_id = aws_route_table.privateRT.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.priv_sub2.id
  route_table_id = aws_route_table.privateRT.id
}
