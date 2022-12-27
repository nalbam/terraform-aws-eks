# aws-auth

# terraform import kubernetes_config_map.aws_auth kube-system/aws-auth

resource "kubernetes_config_map" "aws_auth" {
  count = var.save_aws_auth ? 1 : 0

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
  count = var.save_local_files ? 1 : 0

  filename = "${path.cwd}/.output/aws_auth.yaml"

  content = templatefile("${path.module}/templates/aws_auth.yaml.tpl",
    {
      rolearn    = aws_iam_role.worker.arn
      account_id = local.account_id
      users      = local.users
    }
  )

  file_permission = "0644"
}
