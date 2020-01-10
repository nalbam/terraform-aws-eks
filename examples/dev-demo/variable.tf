# variable

data "aws_caller_identity" "current" {
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "vpc-demo.tfstate"
  }
}

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-demo-eks"
}

variable "kubernetes_version" {
  default = "1.14"
}

variable "allow_ip_address" {
  default = [
    "10.10.1.0/24", # bastion
  ]
}

locals {
  workers = [
    {
      rolearn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/seoul-dev-demo-eks-worker"
    },
  ]
  map_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/seoul-dev-demo-bastion"
      username = "iam-role-bastion"
      group    = "system:masters"
    },
  ]
  map_users = [
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/jungyoul.yu"
      username = "jungyoul.yu"
      group    = "system:masters"
    },
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/developer"
      username = "developer"
      group    = ""
    },
  ]
}
