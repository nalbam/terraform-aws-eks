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
    name                  = data.aws_eks_cluster.cluster.name
    certificate_authority = data.aws_eks_cluster.cluster.certificate_authority.0.data
    endpoint              = data.aws_eks_cluster.cluster.endpoint
    ip_family             = var.ip_family
    version               = data.aws_eks_cluster.cluster.version
  }
}

locals {
  addons_irsa_role = {
    for k, v in var.addons_irsa_name : k => format("arn:aws:iam::%s:role/irsa--%s--%s", local.account_id, var.cluster_name, v)
  }
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
