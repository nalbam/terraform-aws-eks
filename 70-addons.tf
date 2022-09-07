# aws_eks_addon

resource "aws_eks_addon" "aws-ebs-csi-driver" {
  count = lookup(var.addons_version, "aws-ebs-csi-driver", null) != null ? 1 : 0

  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = lookup(var.addons_version, "aws-ebs-csi-driver", null)
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = lookup(local.addons_irsa_role, "aws-ebs-csi-driver", null)
}

resource "aws_eks_addon" "coredns" {
  count = lookup(var.addons_version, "coredns", null) != null ? 1 : 0

  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = "coredns"
  addon_version     = lookup(var.addons_version, "coredns", null)
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = lookup(local.addons_irsa_role, "coredns", null)
}

resource "aws_eks_addon" "kube-proxy" {
  count = lookup(var.addons_version, "kube-proxy", null) != null ? 1 : 0

  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = "kube-proxy"
  addon_version     = lookup(var.addons_version, "kube-proxy", null)
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = lookup(local.addons_irsa_role, "kube-proxy", null)
}

resource "aws_eks_addon" "vpc-cni" {
  count = lookup(var.addons_version, "vpc-cni", null) != null ? 1 : 0

  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = "vpc-cni"
  addon_version     = lookup(var.addons_version, "vpc-cni", null)
  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = lookup(local.addons_irsa_role, "vpc-cni", null)
}
