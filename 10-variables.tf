# variable

variable region {
  default = "us-west-2"
}

variable name {
  default = "demo"
}

variable node_type {
  default = "m4.large"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {}
