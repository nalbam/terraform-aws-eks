# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  tags = merge(
    {
      "KubernetesCluster"                 = var.name
      "kubernetes.io/cluster/${var.name}" = "owned"
    },
    var.tags,
  )
}

locals {
  provider_url = data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
  provider_urn = replace(local.provider_url, "https://", "")
}
