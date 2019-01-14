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

variable "suffix" {
  description = "Name of the cluster, e.g: EKS"
}

variable "vpc_id" {
  description = "The VPC ID."
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC, e.g: 10.0.0.0/16"
  default     = "10.0.0.0/16"
}

variable "subnet_ids" {
  description = "List of Subnet Ids"
  type        = "list"
  default     = []
}

variable max_azs {
  default = "3"
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

variable "allow_ip_address" {
  description = "List of IP Address to permit access"
  type        = "list"
  default     = ["*"]
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
