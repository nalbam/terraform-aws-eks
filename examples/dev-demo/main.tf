# eks

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-mz-seoul"
    key            = "eks-demo.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-mz-seoul"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.certificate_authority)
  token                  = module.eks.token
  load_config_file       = false
}

module "eks" {
  source = "../.."
  region = var.region
  config = local.config.0
}
