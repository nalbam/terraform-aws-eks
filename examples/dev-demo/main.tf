# eks

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-workshop-082867736673"
    key            = "eks-demo.tfstate"
    dynamodb_table = "terraform-resource-lock"
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
    format("%s-worker", var.name),
  ]

  roles = [
    {
      name   = "dev-bastion"
      groups = ["system:masters"]
    },
  ]

  users = [
    {
      name   = "bruce"
      groups = ["system:masters"]
    },
    {
      name   = "developer"
      groups = [""]
    },
    {
      name   = "readonly"
      groups = [""]
    },
  ]
}
