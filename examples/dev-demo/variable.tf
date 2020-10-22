# variable

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-workshop-seoul"
    key    = "vpc-public.tfstate"
  }
}

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "dev-demo-eks"
}

variable "kubernetes_version" {
  default = "1.18"
}

variable "allow_ip_address" {
  default = [
    "10.10.1.0/24", # bastion
  ]
}
