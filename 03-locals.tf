# locals

locals {
  cluster_name = format("%s-cluster", var.cluster_name)
  worker_name  = format("%s-worker", var.cluster_name)
}

# locals {
#   cluster_info = {
#     name                  = data.aws_eks_cluster.cluster.name
#     certificate_authority = data.aws_eks_cluster.cluster.certificate_authority.0.data
#     endpoint              = data.aws_eks_cluster.cluster.endpoint
#     ip_family             = var.ip_family
#     version               = data.aws_eks_cluster.cluster.version
#   }
# }

locals {
  worker_ami_arch    = var.worker_ami_arch == "arm64" ? "amazon-eks-arm64-node" : "amazon-eks-node"
  worker_ami_keyword = format("%s-%s-%s", local.worker_ami_arch, var.kubernetes_version, var.worker_ami_keyword)
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
      "userarn"  = format("arn:aws:iam::%s:user/%s", var.account_id, item)
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
      "KubernetesVersion"                         = var.kubernetes_version
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      "krmt.io/cluster"                           = var.cluster_name
    },
  )
}
