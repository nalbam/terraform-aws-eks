# data

data "aws_availability_zones" "azs" {
}

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "template_file" "aws_auth_workers" {
  count    = length(var.config.workers)
  template = file("${path.module}/templates/aws_auth_workers.yaml.tpl")

  vars = {
    rolearn = var.config.workers[count.index]
  }
}

# data "template_file" "aws_auth_map_roles" {
#   count    = length(var.config.map_roles)
#   template = file("${path.module}/templates/aws_auth_map_roles.yaml.tpl")

#   vars = {
#     rolearn  = var.config.map_roles[count.index]["rolearn"]
#     username = var.config.map_roles[count.index]["username"]
#     groups   = var.config.map_roles[count.index]["groups"][0]
#   }
# }

# data "template_file" "aws_auth_map_users" {
#   count    = length(var.config.map_users)
#   template = file("${path.module}/templates/aws_auth_map_users.yaml.tpl")

#   vars = {
#     userarn  = var.config.map_users[count.index]["userarn"]
#     username = var.config.map_users[count.index]["username"]
#     groups   = var.config.map_users[count.index]["groups"][0]
#   }
# }

# data "template_file" "aws_auth" {
#   template = file("${path.module}/templates/aws_auth.yaml.tpl")

#   vars = {
#     workers   = join("", data.template_file.aws_auth_workers.*.rendered)
#     map_roles = join("", data.template_file.aws_auth_map_roles.*.rendered)
#     map_users = join("", data.template_file.aws_auth_map_users.*.rendered)
#   }
# }

# data "template_file" "aws_config" {
#   template = file("${path.module}/templates/aws_config.conf.tpl")

#   vars = {
#     REGION = var.region
#   }
# }

# data "template_file" "kube_config" {
#   template = file("${path.module}/templates/kube_config.yaml.tpl")

#   vars = {
#     CERTIFICATE     = aws_eks_cluster.cluster.certificate_authority[0].data
#     MASTER_ENDPOINT = aws_eks_cluster.cluster.endpoint
#     CLUSTER_NAME    = aws_eks_cluster.cluster.name
#   }
# }

# data "template_file" "kube_config_secret" {
#   template = file("${path.module}/templates/kube_config_secret.yaml.tpl")

#   vars = {
#     CLUSTER_NAME = aws_eks_cluster.cluster.name
#     AWS_CONFIG   = base64encode(data.template_file.aws_config.rendered)
#     KUBE_CONFIG  = base64encode(data.template_file.kube_config.rendered)
#   }
# }
