# eks

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "eks.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "eks" {
  source = "../../modules/eks"

  region = "ap-northeast-1"
  city   = "TOKYO"
  stage  = "DEV"
  name   = "DEMO"

  cidr_block = "10.11.0.0/16"

  instance_type = "m4.large"
  desired       = "2"
  min           = "2"
  max           = "5"

  key_name = "nalbam-tokyo"

  admin_cidr = "58.151.93.9/32" # echo "$(curl -sL icanhazip.com)/32"
}

output "config" {
  value = "${module.eks.config}"
}
