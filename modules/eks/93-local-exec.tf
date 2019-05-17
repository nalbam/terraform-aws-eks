# aws auth

resource "null_resource" "executor" {
  depends_on = ["aws_eks_cluster.cluster"]

  provisioner "local-exec" {
    working_dir = "${path.module}"

    command = <<EOS
echo "${null_resource.executor.triggers.aws_auth}" > aws_auth.yaml & \
echo "${null_resource.executor.triggers.kube_config}" > kube_config.yaml & \
echo "${null_resource.executor.triggers.role_admin}" > role_admin.yaml & \
echo "${null_resource.executor.triggers.role_view}" > role_view.yaml & \
for i in `seq 1 10`; do \
  kubectl apply -f aws_auth.yaml --kubeconfig kube_config.yaml && break || sleep 10; \
done; \
kubectl apply -f role_admin.yaml --kubeconfig kube_config.yaml & \
kubectl apply -f role_view.yaml --kubeconfig kube_config.yaml
EOS

    interpreter = ["${var.local_exec_interpreter}"]
  }

  triggers {
    aws_auth    = "${data.template_file.aws_auth.rendered}"
    kube_config = "${data.template_file.kube_config.rendered}"
    role_admin  = "${data.template_file.cluster_role_binding_admin.rendered}"
    role_view   = "${data.template_file.cluster_role_binding_view.rendered}"
    endpoint    = "${aws_eks_cluster.cluster.endpoint}"
  }
}
