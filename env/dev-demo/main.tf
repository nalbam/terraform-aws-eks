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

  vpc_id = "vpc-061dc55df85dea9f1"

  subnet_ids = [
    "subnet-000602ea8ac0aaf8f",
    "subnet-041179c58d07b38dd",
  ]

  launch_configuration_enable = false
  launch_template_enable      = true

  instance_type = "m4.large"

  mixed_instances = ["r4.large", "c4.large"]

  min = "0"
  max = "10"

  key_name = "nalbam-seoul"

  allow_ip_address = [
    "58.151.93.9/32", # 강남 echo "$(curl -sL icanhazip.com)/32"
  ]
}

output "name" {
  value = "${module.eks.name}"
}

output "config" {
  value = "${module.eks.config}"
}

output "worker_sg_id" {
  value = "${module.eks.worker_sg_id}"
}
