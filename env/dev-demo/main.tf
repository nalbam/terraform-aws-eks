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

  # vpc_id     = ""
  # subnet_ids = []
  vpc_cidr = "10.20.0.0/16"

  max_azs = "1"

  instance_type = "m4.large"
  desired       = "2"
  min           = "2"
  max           = "5"

  key_name = "nalbam-seoul"

  allow_ip_address = [
    "58.151.93.9/32", # 강남 echo "$(curl -sL icanhazip.com)/32"
  ]
}

output "config" {
  value = "${module.eks.config}"
}
