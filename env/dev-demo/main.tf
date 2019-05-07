# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "eks.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "eks" {
  source = "../../modules/eks"

  region = "ap-northeast-2"
  city   = "SEOUL"
  stage  = "DEV"
  name   = "DEMO"
  suffix = "EKS"

  kubernetes_version = "1.12"

  vpc_id = "vpc-00c644066e3a8d97d"

  subnet_ids = [
    "subnet-0c29ad66d2500c8a1",
    "subnet-0f33970fc136666e5",
  ]

  buckets = [
    "artifact",
  ]

  launch_efs_enable = true

  launch_configuration_enable = false
  launch_template_enable      = true

  associate_public_ip_address = true

  instance_type = "m4.large"

  mixed_instances = ["m5.large", "r4.large", "r5.large"]

  volume_size = "32"

  min = "1"
  max = "5"

  on_demand_base = "0"
  on_demand_rate = "0"

  key_name = "nalbam-seoul"

  allow_ip_address = [
    "10.10.1.0/24", # bastion
  ]

  map_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/SEOUL-DEV-DEMO-BASTION"
      username = "iam_role_bastion"
      group    = "system:masters"
    },
  ]

  map_users = [
    {
      user     = "user/admin"
      username = "iam_user_admin"
      group    = "system:masters"
    },
    {
      user     = "user/dev"
      username = "iam_user_dev"
      group    = "system:masters"
    },
  ]
}

data "aws_caller_identity" "current" {}

output "config" {
  value = "${module.eks.config}"
}
