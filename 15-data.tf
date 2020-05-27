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

# aws_auth_workers
data "template_file" "aws_auth_workers" {
  count    = length(var.workers)
  template = file("${path.module}/templates/aws_auth_workers.yaml.tpl")

  vars = {
    rolearn = var.workers[count.index]
  }
}

# aws_config
data "template_file" "aws_config" {
  template = file("${path.module}/templates/aws_config.conf.tpl")

  vars = {
    REGION = var.region
    OUTPUT = "json"
  }
}

# kube_config
data "template_file" "kube_config" {
  template = file("${path.module}/templates/kube_config.yaml.tpl")

  vars = {
    CERTIFICATE     = data.aws_eks_cluster.cluster.certificate_authority.0.data
    MASTER_ENDPOINT = data.aws_eks_cluster.cluster.endpoint
    CLUSTER_NAME    = data.aws_eks_cluster.cluster.name
  }
}

data "template_file" "kube_config_secret" {
  template = file("${path.module}/templates/kube_config_secret.yaml.tpl")

  vars = {
    CLUSTER_NAME = data.aws_eks_cluster.cluster.name
    AWS_CONFIG   = base64encode(data.template_file.aws_config.rendered)
    KUBE_CONFIG  = base64encode(data.template_file.kube_config.rendered)
  }
}
