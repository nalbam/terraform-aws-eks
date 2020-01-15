# local file

resource "local_file" "kube_config" {
  count    = var.save_local_file ? 1 : 0
  content  = data.template_file.kube_config.rendered
  filename = "${path.cwd}/.output/kube_config.yaml"
}

resource "local_file" "kube_config_secret" {
  count    = var.save_local_file ? 1 : 0
  content  = data.template_file.kube_config_secret.rendered
  filename = "${path.cwd}/.output/kube_config_secret.yaml"
}
