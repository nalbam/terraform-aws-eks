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
