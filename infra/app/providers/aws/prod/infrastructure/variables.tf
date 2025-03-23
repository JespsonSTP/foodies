variable "primary_region" {
  description = "app region"
  type = string
  default = "us-east-2"
}
variable "application_name" {
  description = "app region"
  type = string
  default = "foodies"
}
variable "environment_name" {
  description = "app region"
  type = string
  default = "prod"
}

variable "az_count" {
  type = string
  default = 3
}


variable "cidr_vpc" {
  description = "vpc cidr notation"
  type = string
  default = "10.0.0.0/16"
}