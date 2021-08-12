# kube_config

data "template_file" "kube_config" {
  template = file("${path.module}/templates/kube_config.yaml.tpl")

  vars = {
    ACCOUNT_ID          = local.account_id
    AWS_REGION          = data.aws_region.current.name
    CLUSTER_CERTIFICATE = data.aws_eks_cluster.cluster.certificate_authority[0].data
    CLUSTER_ENDPOINT    = data.aws_eks_cluster.cluster.endpoint
    CLUSTER_NAME        = var.cluster_name
  }
}

resource "local_file" "kube_config" {
  count = var.save_local_files ? 1 : 0

  content = data.template_file.kube_config.rendered

  filename = "${path.cwd}/.output/kube_config.yaml"
}
