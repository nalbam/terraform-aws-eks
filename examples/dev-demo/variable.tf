# variable

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-workshop-082867736673"
    key    = "vpc-public.tfstate"
  }
}

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "eks-demo"
}

variable "kubernetes_version" {
  default = "1.18"
}

variable "allow_ip_address" {
  default = [
    "10.10.1.0/24", # bastion
  ]
}
