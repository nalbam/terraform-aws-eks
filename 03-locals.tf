# locals

locals {
  region = data.aws_region.current.name

  account_id = data.aws_caller_identity.current.account_id
}

locals {
  cluster_name = format("%s-cluster", var.cluster_name)
  worker_name  = format("%s-worker", var.cluster_name)
}

locals {
  cluster_info = {
    name      = data.aws_eks_cluster.cluster.name
    version   = data.aws_eks_cluster.cluster.version
    endpoint  = data.aws_eks_cluster.cluster.endpoint
    ip_family = var.ip_family
    oidc = {
      arn = aws_iam_openid_connect_provider.cluster.arn
      url = aws_iam_openid_connect_provider.cluster.url
    }
    role = {
      arn  = aws_iam_role.cluster.arn
      name = aws_iam_role.cluster.name
    }
  }

  worker_info = {
    role = {
      arn  = aws_iam_role.worker.arn
      name = aws_iam_role.worker.name
    }
    instance_profile_name = aws_iam_instance_profile.worker.name
  }
}

locals {
  roles = [
    for item in var.iam_roles :
    {
      "rolearn"  = item.role
      "username" = item.name
      "groups"   = item.groups
    }
  ]

  masters = var.iam_group != "" ? compact(concat(var.masters, data.aws_iam_group.master[0].users.*.user_name)) : var.masters

  users = [
    for item in local.masters :
    {
      "userarn"  = format("arn:aws:iam::%s:user/%s", local.account_id, item)
      "username" = format("iam-user-%s", item)
      "groups"   = ["system:masters"]
    }
  ]
}

locals {
  tags = merge(
    var.tags,
    {
      "KubernetesCluster"                         = var.cluster_name
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    },
  )
}
