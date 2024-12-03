resource "aws_subnet" "db_sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
}

resource "aws_subnet" "db_sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
}

resource "aws_route_table_association" "dbsub_association1" {
  subnet_id      = aws_subnet.db_sub1.id
  route_table_id = aws_route_table.privateRT.id
}

resource "aws_route_table_association" "dbsub_association2" {
  subnet_id      = aws_subnet.db_sub2.id
  route_table_id = aws_route_table.privateRT.id
}
