variable region {
  default = "us-east-1"
}

variable stage {
  default = "dev"
}

variable name {
  default = "nalbam"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "azs" {
  type = "list"
  default = ["us-east-1a","us-east-1b","us-east-1d"]
}
