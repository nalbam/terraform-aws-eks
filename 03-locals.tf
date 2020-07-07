# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  tags = merge(
    {
      "Name"              = var.name
      "KubernetesCluster" = var.name
    },
    var.tags,
  )

  sub_tags = merge(
    local.tags,
    {
      "kubernetes.io/cluster/${var.name}" = "owned"
    },
  )
}
