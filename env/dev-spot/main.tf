# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "eks-spot.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-2"
}

module "eks" {
  source = "../../modules/eks"

  region = "ap-northeast-2"
  city   = "SEOUL"
  stage  = "DEV"
  name   = "SPOT"
  suffix = "EKS"

  kubernetes_version = "1.12"

  vpc_id = "vpc-00c644066e3a8d97d"

  subnet_ids = [
    "subnet-0c29ad66d2500c8a1",
    "subnet-0bcc6818c3c96b827",
    "subnet-01ba9f9879fcf178b",
  ]

  buckets = [
    "artifact",
  ]

  launch_efs_enable = true

  launch_configuration_enable = false
  launch_template_enable      = true

  associate_public_ip_address = true

  instance_type = "m4.large"

  volume_size = "32"

  min = "1"
  max = "5"

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
      user     = "user/jungyoul.yu"
      username = "jungyoul.yu"
      group    = "system:masters"
    },
    {
      user     = "user/username"
      username = "username"
      group    = ""
    },
  ]
}

data "aws_caller_identity" "current" {
}

output "config" {
  value = module.eks.config
}
