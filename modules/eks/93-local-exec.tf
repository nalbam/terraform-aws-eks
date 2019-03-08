# aws auth

resource "null_resource" "aws_auth" {
  depends_on = ["aws_eks_cluster.cluster"]

  provisioner "local-exec" {
    working_dir = "${path.module}"

    command = <<EOS
for i in `seq 1 10`; do \
  echo "${null_resource.aws_auth.triggers.kube_config}" > kube_config.yaml & \
  echo "${null_resource.aws_auth.triggers.aws_auth}" > aws_auth.yaml & \
  kubectl apply -f aws_auth.yaml --kubeconfig kube_config.yaml && break || \
  sleep 10; \
done; \
rm aws_auth.yaml kube_config.yaml;
EOS

    interpreter = ["${var.local_exec_interpreter}"]
  }

  triggers {
    kube_config = "${data.template_file.kube_config.rendered}"
    aws_auth    = "${data.template_file.aws_auth.rendered}"
    endpoint    = "${aws_eks_cluster.cluster.endpoint}"
  }
}
