variable "application_name" {
  description = "app region"
  type = string
  default = "foodies"
}
variable "az_count" {
  type = string
  default = 3
}

variable "environment_name" {
  description = "app region"
  type = string
  default = "dev"
}

variable "cidr_vpc" {
  description = "vpc cidr notation"
  type = string
  default = "10.0.0.0/16"
}


variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "eks_subnet_cidrs" {
  description = "List of CIDR blocks for EKS subnets"
  type        = list(string)
  default = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}