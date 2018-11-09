# eks

provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key = "eks.tfstate"
  }
}

module "eks" {
  source     = "./modules/eks"
  region     = "us-west-2"
  name       = "demo"
  node_type  = "m4.large"
  cidr_block = "10.8.0.0/16"
  desired    = "2"
  min        = "2"
  max        = "5"
}

output "config" {
  value = "${module.eks.config}"
}
