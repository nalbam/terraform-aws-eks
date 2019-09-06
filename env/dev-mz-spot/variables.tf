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
  default = "spot"
}

variable "suffix" {
  default = "eks"
}

variable "vpc_id" {
  default = "vpc-018a61f4f7cfedf46"
}

variable "subnet_ids" {
  default = [
    "subnet-053ee10649577323f",
    "subnet-00bbcda81a83ed5b3",
    "subnet-0490973094e02cb6c",
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
