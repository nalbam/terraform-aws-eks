# variable

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "seoul-dev-spot-eks"
}

variable "kubernetes_version" {
  default = "1.14"
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

variable "allow_ip_address" {
  default = [
    "10.11.1.0/24", # bastion
  ]
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

variable "launch_configuration_enable" {
  default = false
}

variable "launch_template_enable" {
  default = true
}

variable "launch_each_subnet" {
  default = true
}

variable "associate_public_ip_address" {
  default = false
}

variable "instance_type" {
  default = "m5.large"
}

variable "mixed_instances" {
  default = []
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "32"
}

variable "min" {
  default = "1"
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
