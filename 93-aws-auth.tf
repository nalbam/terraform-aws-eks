# aws-auth

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

#   data = {
#     mapRoles = <<EOF
# ${join("", distinct(concat(data.template_file.aws_auth_workers.*.rendered)))}
# ${join("", distinct(concat(data.template_file.aws_auth_roles.*.rendered)))}
# EOF
#     mapUsers = <<EOF
# ${join("", distinct(concat(data.template_file.aws_auth_users.*.rendered)))}
# EOF
#   }

  data = {
    mapRoles = yamlencode(local.roles)
    mapUsers = yamlencode(local.users)
  }

  depends_on = [aws_eks_cluster.cluster]
}
