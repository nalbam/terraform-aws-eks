# eks cluster

resource "aws_eks_cluster" "cluster" {
  name     = var.config.name
  role_arn = aws_iam_role.cluster.arn
  version  = var.config.kubernetes_version

  vpc_config {
    subnet_ids         = var.config.subnet_ids
    security_group_ids = [aws_security_group.cluster.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy,
  ]
}
