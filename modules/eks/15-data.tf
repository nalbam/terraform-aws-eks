# data

data "aws_availability_zones" "azs" {
}

data "aws_caller_identity" "current" {
}

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.kubernetes_version}-*"]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}

data "template_file" "kube_config" {
  template = file("${path.module}/template/kube_config.yaml.tpl")

  vars = {
    CERTIFICATE     = aws_eks_cluster.cluster.certificate_authority[0].data
    MASTER_ENDPOINT = aws_eks_cluster.cluster.endpoint
    CLUSTER_NAME    = local.full_name
  }
}

data "template_file" "kube_config_secret" {
  template = file("${path.module}/template/kube_config_secret.yaml.tpl")

  vars = {
    CLUSTER_NAME = local.full_name
    ENCODED_TEXT = base64encode(data.template_file.kube_config.rendered)
  }
}

data "template_file" "aws_auth_map_roles" {
  count    = length(var.map_roles)
  template = file("${path.module}/template/aws_auth_map_roles.yaml.tpl")

  vars = {
    rolearn  = var.map_roles[count.index]["rolearn"]
    username = var.map_roles[count.index]["username"]
    group    = var.map_roles[count.index]["group"]
  }
}

data "template_file" "aws_auth_map_users" {
  count    = length(var.map_users)
  template = file("${path.module}/template/aws_auth_map_users.yaml.tpl")

  vars = {
    userarn  = var.map_users[count.index]["userarn"]
    username = var.map_users[count.index]["username"]
    group    = var.map_users[count.index]["group"]
  }
}

data "template_file" "aws_auth" {
  template = file("${path.module}/template/aws_auth.yaml.tpl")

  vars = {
    rolearn   = module.worker.iam_role_arn
    map_roles = join("", data.template_file.aws_auth_map_roles.*.rendered)
    map_users = join("", data.template_file.aws_auth_map_users.*.rendered)
  }
}
