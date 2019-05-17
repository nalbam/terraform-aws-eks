# local file

resource "local_file" "aws_auth" {
  content  = "${data.template_file.aws_auth.rendered}"
  filename = "${path.cwd}/.output/aws_auth.yaml"
}

resource "local_file" "kube_config" {
  content  = "${data.template_file.kube_config.rendered}"
  filename = "${path.cwd}/.output/kube_config.yaml"
}

resource "local_file" "kube_config_secret" {
  content  = "${data.template_file.kube_config_secret.rendered}"
  filename = "${path.cwd}/.output/kube_config_secret.yaml"
}

resource "local_file" "cluster_role_binding_admin" {
  content  = "${data.template_file.cluster_role_binding_admin.rendered}"
  filename = "${path.cwd}/.output/cluster_role_binding_admin.yaml"
}

resource "local_file" "cluster_role_binding_view" {
  content  = "${data.template_file.cluster_role_binding_view.rendered}"
  filename = "${path.cwd}/.output/cluster_role_binding_view.yaml"
}
