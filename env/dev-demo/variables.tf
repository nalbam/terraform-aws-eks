variable "region" {
  default = "ap-northeast-2"
}

variable "city" {
  default = "seoul"
}

variable "stage" {
  default = "dev"
}

variable "name" {
  default = "demo"
}

variable "suffix" {
  default = "eks"
}

variable "vpc_id" {
  default = "vpc-075279b4e48b983ff"
}

variable "subnet_ids" {
  default = [
    "subnet-08a5b599722126606",
    "subnet-08d4e11f445bb207f",
    "subnet-0706fbc7ebe262da7",
  ]
}

variable "kubernetes_version" {
  default = "1.14"
}

data "aws_caller_identity" "current" {
}

locals {
  full_name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"
}
