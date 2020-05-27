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

  data = {
    mapRoles = <<EOF
${join("", distinct(concat(data.template_file.aws_auth_workers.*.rendered)))}
%{if length(var.map_roles) != 0}${yamlencode(var.map_roles)}%{endif}
EOF
    mapUsers = yamlencode(var.map_users)
    # mapAccounts = yamlencode(var.map_accounts)
  }

  depends_on = [aws_eks_cluster.cluster]
}
