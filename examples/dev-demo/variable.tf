# variable

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
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

variable "launch_configuration_enable" {
  default = false
}

variable "launch_template_enable" {
  default = true
}

variable "launch_each_subnet" {
  default = false
}

variable "associate_public_ip_address" {
  default = false
}

variable "instance_type" {
  default = "m5.large"
}

variable "mixed_instances" {
  default = ["c5.large", "r5.large"]
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "32"
}

variable "min" {
  default = "2"
}

variable "max" {
  default = "5"
}

variable "on_demand_base" {
  default = "0"
}

variable "on_demand_rate" {
  default = "0"
}

variable "key_name" {
  default = "nalbam-seoul"
}

variable "key_path" {
  default = ""
}

variable "launch_efs_enable" {
  default = true
}

variable "buckets" {
  default = []
}

data "aws_caller_identity" "current" {
}

locals {
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
