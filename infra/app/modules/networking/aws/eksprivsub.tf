resource "aws_subnet" "eks_sub" {

  for_each = local.subnet_definitions.eks
  vpc_id            = aws_vpc.main.id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name                           = "EKS Subnet ${each.key}"
    "kubernetes.io/cluster/foodies-eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

}


resource "aws_route_table_association" "eks_sub_rt" {
  for_each = aws_subnet.eks_sub
  subnet_id      = each.value.id
  route_table_id = aws_route_table.privateRT.id
}