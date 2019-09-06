# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "eks-demo.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "eks" {
  source = "../../modules/eks"

  region = var.region
  city   = var.city
  stage  = var.stage
  name   = var.name
  suffix = var.suffix

  vpc_id = var.vpc_id

  subnet_ids = var.subnet_ids

  kubernetes_version = var.kubernetes_version

  allow_ip_address = [
    "10.10.1.0/24", # bastion
  ]

  # aws-auth
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

  # worker
  launch_configuration_enable = false
  launch_template_enable      = true
  launch_each_subnet          = true

  associate_public_ip_address = false

  instance_type = "m5.large"

  mixed_instances = ["c5.large", "r5.large"]

  volume_size = "32"

  min = "1"
  max = "5"

  on_demand_base = "0"
  on_demand_rate = "0"

  key_name = "nalbam-seoul"

  # efs
  launch_efs_enable = true

  # # s3
  # buckets = [
  #   "argo",
  # ]
}

output "config" {
  value = module.eks.config
}
