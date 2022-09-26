# data

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "aws_ec2_managed_prefix_list" "sslvpn" {
  count = var.sslvpn_name != "" ? 1 : 0

  name = var.sslvpn_name
}
