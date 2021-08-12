# aws-auth

resource "kubernetes_config_map" "aws_auth" {
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
