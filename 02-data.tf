# data

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "aws_iam_group" "master" {
  count = var.iam_group != "" ? 1 : 0

  group_name = var.iam_group
}

data "aws_ec2_managed_prefix_list" "sslvpn" {
  count = var.sslvpn_name != "" ? 1 : 0

  name = var.sslvpn_name
}

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = [local.worker_ami_keyword]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}
