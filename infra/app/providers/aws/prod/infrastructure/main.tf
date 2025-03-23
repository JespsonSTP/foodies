module "networking" {
  source = "../../../../modules/networking/aws"
  cidr_vpc    = var.cidr_vpc
  environment_name = var.environment_name
}