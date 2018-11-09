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

variable desired {
  default = "2"
}

variable min {
  default = "2"
}

variable max {
  default = "5"
}

variable az_count {
  default = "2"
}

data "aws_availability_zones" "available" {}
