# eks cluster

resource "aws_eks_cluster" "cluster" {
  name     = var.name
  role_arn = aws_iam_role.cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [aws_security_group.cluster.id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  enabled_cluster_log_types = var.cluster_log_types

  tags = merge(
    local.tags,
    {
      "Name" = var.name
    },
  )

  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.this,
  ]
}

resource "aws_cloudwatch_log_group" "this" {
  count = length(var.cluster_log_types) > 0 ? 1 : 0

  name_prefix       = format("/aws/eks/%s-", var.name)
  retention_in_days = var.cluster_log_retention_in_days
  kms_key_id        = var.cluster_log_kms_key_id

  tags = merge(
    local.tags,
    {
      "Name" = var.name
    },
  )
}
