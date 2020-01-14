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
  names = [
    "${var.name}",
    # "${var.name}-b",
    # "${var.name}-c",
  ]

  account_id = data.aws_caller_identity.current.account_id
}

locals {
  config = [
    for name in local.names : {
      name               = name,
      vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id,
      subnet_ids         = data.terraform_remote_state.vpc.outputs.private_subnet_ids,
      kubernetes_version = var.kubernetes_version,
      allow_ip_address   = var.allow_ip_address,
      workers = [
        "arn:aws:iam::${local.account_id}:role/${name}-worker",
        "arn:aws:iam::${local.account_id}:role/${name}-private",
        "arn:aws:iam::${local.account_id}:role/${name}-public",
      ],
      map_roles = local.map_roles,
      map_users = local.map_users,
    },
  ]
}

locals {
  map_roles = [
    {
      rolearn  = "arn:aws:iam::${local.account_id}:role/seoul-dev-demo-bastion"
      username = "iam-role-bastion"
      groups   = ["system:masters"]
    },
  ]
  map_users = [
    {
      userarn  = "arn:aws:iam::${local.account_id}:user/jungyoul.yu"
      username = "jungyoul.yu"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::${local.account_id}:user/developer"
      username = "developer"
      groups   = [""]
    },
  ]
}
