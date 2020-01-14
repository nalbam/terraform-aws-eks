# local file

resource "local_file" "kube_config" {
  content  = data.template_file.kube_config.rendered
  filename = "${path.cwd}/.output/kube_config.yaml"
}

resource "local_file" "kube_config_secret" {
  content  = data.template_file.kube_config_secret.rendered
  filename = "${path.cwd}/.output/kube_config_secret.yaml"
}
