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
  source = "../../"

  region = var.region
  name   = var.name

  vpc_id = var.vpc_id

  subnet_ids = var.subnet_ids

  kubernetes_version = var.kubernetes_version

  allow_ip_address = var.allow_ip_address

  map_roles = local.map_roles
  map_users = local.map_users

  launch_configuration_enable = var.launch_configuration_enable
  launch_template_enable      = var.launch_template_enable

  launch_each_subnet          = var.launch_each_subnet
  associate_public_ip_address = var.associate_public_ip_address

  instance_type = var.instance_type

  mixed_instances = var.mixed_instances

  volume_type = var.volume_type
  volume_size = var.volume_size

  min = var.min
  max = var.max

  on_demand_base = var.on_demand_base
  on_demand_rate = var.on_demand_rate

  key_name = var.key_name
  key_path = var.key_path

  launch_efs_enable = var.launch_efs_enable

  buckets = var.buckets
}
