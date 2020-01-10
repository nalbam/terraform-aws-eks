# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-mz-seoul"
    key    = "eks-demo.tfstate"
    # encrypt        = true
    # dynamodb_table = "terraform-resource-lock"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "eks" {
  source = "../.."

  region = var.region
  name   = var.name

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  kubernetes_version = var.kubernetes_version

  allow_ip_address = var.allow_ip_address

  workers   = local.workers
  map_roles = local.map_roles
  map_users = local.map_users
}
