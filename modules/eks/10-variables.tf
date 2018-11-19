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

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable instance_type {
  default = "m4.large"
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

variable key_name {
  default = ""
}

variable "key_path" {
  default = ""
}

variable admin_cidr {
  default = ""
}

variable "cities" {
  type = "map"

  default = {
    ap-northeast-1 = "Tokyo"
    ap-northeast-2 = "Seoul"
    ap-south-1     = "Mumbai"
    ap-southeast-1 = "Singapore"
    ap-southeast-2 = "Sydney"
    ca-central-1   = "Central"
    eu-central-1   = "Frankfurt"
    eu-west-1      = "Ireland"
    eu-west-2      = "London"
    eu-west-3      = "Paris"
    sa-east-1      = "SãoPaulo"
    us-east-1      = "Virginia"
    us-east-2      = "Ohio"
    us-west-1      = "California"
    us-west-2      = "Oregon"
  }
}
