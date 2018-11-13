# variable

variable "region" {
  description = "The region to deploy the cluster in, e.g: us-east-1"
}

variable "city" {
  description = "City Name of the cluster, e.g: VIRGINIA"
}

variable "stage" {
  description = "Stage Name of the cluster, e.g: DEV"
}

variable "name" {
  description = "Name of the cluster, e.g: DEMO"
}

variable instance_type {
  default = "m4.large"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable desired {
  default = "2"
}

variable min {
  default = "2"
}

variable max {
  default = "5"
}

data "aws_availability_zones" "azs" {}
