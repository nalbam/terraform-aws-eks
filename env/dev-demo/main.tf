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

  vpc_id = "vpc-061dc55df85dea9f1"

  subnet_ids = [
    "subnet-000602ea8ac0aaf8f",
    "subnet-041179c58d07b38dd",
  ]

  launch_efs_enable = true

  launch_configuration_enable = false
  launch_template_enable      = true

  instance_type = "m5.large"

  mixed_instances = ["m4.large", "r4.large", "r5.large"]

  volume_size = "32"

  min = "1"
  max = "10"

  key_name = "nalbam-seoul"

  allow_ip_address = [
    "58.151.93.9/32", # 강남 echo "$(curl -sL icanhazip.com)/32"
    "10.10.1.0/24",   # bastion
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
      username = "iam_user_jungyoul.yu"
      group    = "system:masters"
    },
  ]
}

data "aws_caller_identity" "current" {}

output "name" {
  value = "${module.eks.name}"
}

output "config" {
  value = "${module.eks.config}"
}

output "worker_sg_id" {
  value = "${module.eks.worker_sg_id}"
}
