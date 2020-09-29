# eks

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-nalbam-seoul"
    key            = "eks-demo.tfstate"
    dynamodb_table = "terraform-nalbam-seoul"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "eks" {
  source = "../../"

  region = var.region
  name   = var.name

  kubernetes_version = var.kubernetes_version

  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  allow_ip_address = var.allow_ip_address

  workers = [
    "arn:aws:iam::${local.account_id}:role/${var.name}-worker",
    "arn:aws:iam::${local.account_id}:role/${var.name}-private",
    "arn:aws:iam::${local.account_id}:role/${var.name}-public",
  ]

  map_roles = local.map_roles
  map_users = local.map_users
}
