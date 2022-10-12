# aws-auth

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file       = false
}

resource "kubernetes_config_map" "aws_auth" {
  count = var.apply_aws_auth ? 1 : 0

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(local.roles)
    mapUsers = yamlencode(local.users)
  }

  depends_on = [aws_eks_cluster.cluster]
}

resource "local_file" "aws_auth" {
  count = var.save_aws_auth ? 1 : 0

  filename = "${path.cwd}/.output/aws_auth.yaml"

  content = templatefile("${path.module}/templates/aws_auth.yaml.tpl",
    {
      rolearn    = aws_iam_role.worker.arn
      account_id = local.account_id
      users      = local.masters
    }
  )

  file_permission = "0644"
}
