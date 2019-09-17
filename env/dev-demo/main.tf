# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
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
  name   = var.name

  vpc_id = var.vpc_id

  subnet_ids = var.subnet_ids

  kubernetes_version = "1.14"

  allow_ip_address = var.allow_ip_address

  map_roles = local.map_roles
  map_users = local.map_users

  launch_configuration_enable = false
  launch_template_enable      = true
  launch_each_subnet          = true

  associate_public_ip_address = true

  instance_type = "m5.large"

  mixed_instances = ["c5.large", "r5.large"]

  volume_size = "32"

  min = "1"
  max = "5"

  on_demand_base = "0"
  on_demand_rate = "0"

  key_name = "nalbam-seoul"

  launch_efs_enable = true

  buckets = [
    "argo",
  ]
}
