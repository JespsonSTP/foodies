variable "region" {
  description = "cluster region"
  type = string
  default = "us-east-2"
}

variable "jenkins_cidr_block" {
  description = "VPC CIDR block"
  default     = "192.168.2.0/26"
}

variable "jenkins_vpc" {
  default = "jenkins-vpc"
}