variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-spot-eks"
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
