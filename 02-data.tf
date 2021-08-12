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

data "aws_iam_group" "master" {
  count = var.iam_group != "" ? 1 : 0

  group_name = var.iam_group
}
