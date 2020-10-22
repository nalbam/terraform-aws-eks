# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  cluster_name = format("%s-cluster", var.name)

  worker_name = format("%s-worker", var.name)
}

locals {
  roles = concat(
    [
      for item in var.workers:
      {
        "rolearn" = format("arn:aws:iam::%s:role/%s", local.account_id, item)
        "username"= "system:node:{{EC2PrivateDNSName}}"
        "groups"  = ["system:bootstrappers", "system:nodes"]
      }
    ],
    [
      for item in var.roles:
      {
        "rolearn" = format("arn:aws:iam::%s:role/%s", local.account_id, item["name"])
        "username"= format("iam-role-%s", item["name"])
        "groups"  = item["groups"]
      }
    ],
  )

  users = [
    for item in var.users:
    {
      "userarn" = format("arn:aws:iam::%s:user/%s", local.account_id, item["name"])
      "username"= format("iam-user-%s", item["name"])
      "groups"  = item["groups"]
    }
  ]
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
