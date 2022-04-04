# cluster

resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name

  version = var.kubernetes_version

  role_arn = aws_iam_role.cluster.arn

  enabled_cluster_log_types = var.cluster_log_types

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [aws_security_group.cluster.id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  kubernetes_network_config {
    ip_family = var.ip_family
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.cluster_name
    },
  )

  depends_on = [
    aws_cloudwatch_log_group.cluster,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
  ]
}

resource "aws_cloudwatch_log_group" "cluster" {
  name_prefix = format("/aws/eks/%s-", var.cluster_name)

  retention_in_days = var.retention_in_days

  tags = merge(
    local.tags,
    {
      "Name" = var.cluster_name
    },
  )
}
