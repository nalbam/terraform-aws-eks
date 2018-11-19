# data

data "aws_availability_zones" "azs" {}

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-*"]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}

data "template_file" "kube_config" {
  template = "${file("${path.module}/data/kube_config.yaml")}"

  vars {
    CERTIFICATE     = "${aws_eks_cluster.cluster.certificate_authority.0.data}"
    MASTER_ENDPOINT = "${aws_eks_cluster.cluster.endpoint}"
    CLUSTER_NAME    = "${local.lower_name}"
  }
}

data "template_file" "aws_auth" {
  template = "${file("${path.module}/data/aws_auth.yaml")}"

  vars {
    AWS_IAM_ROLE_ARN = "${aws_iam_role.worker.arn}"
  }
}

data "template_file" "aws_ebs_gp2" {
  template = "${file("${path.module}/data/aws_ebs_gp2.yaml")}"
}
