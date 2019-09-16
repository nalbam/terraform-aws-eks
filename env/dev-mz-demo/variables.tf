variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-demo-eks"
}

variable "vpc_id" {
  default = "vpc-025ad1e9d1cb3c27d"
}

variable "subnet_ids" {
  default = [
    "subnet-09a6bcc0e50e97446",
    "subnet-0bf8251e3c5ea6635",
    "subnet-0c599871d06e90acf",
  ]
}

variable "kubernetes_version" {
  default = "1.14"
}

data "aws_caller_identity" "current" {
}
