# aws-auth

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  depends_on = [aws_eks_cluster.cluster]

  data = {
    mapRoles = <<EOF
${join("", distinct(concat(data.template_file.aws_auth_workers.*.rendered
)))}
%{if length(var.config.map_roles) != 0}${yamlencode(var.config.map_roles)}%{endif}
EOF
mapUsers = yamlencode(var.config.map_users)
# mapAccounts = yamlencode(var.config.map_accounts)
}

}
