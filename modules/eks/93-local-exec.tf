# aws auth

resource "null_resource" "executor" {
  depends_on = ["aws_eks_cluster.cluster"]

  provisioner "local-exec" {
    working_dir = "${path.module}"

    command = <<EOS
echo "${null_resource.executor.triggers.aws_auth}" > .output/_exec_aws_auth.yaml & \
echo "${null_resource.executor.triggers.kube_config}" > .output/_exec_kube_config.yaml & \
echo "${null_resource.executor.triggers.role_admin}" > .output/_exec_role_admin.yaml & \
echo "${null_resource.executor.triggers.role_view}" > .output/_exec_role_view.yaml & \
for i in `seq 1 10`; do \
  kubectl apply -f .output/_exec_aws_auth.yaml --kubeconfig .output/_exec_kube_config.yaml && break || sleep 10; \
done; \
kubectl apply -f .output/_exec_role_admin.yaml --kubeconfig .output/_exec_kube_config.yaml & \
kubectl apply -f .output/_exec_role_view.yaml --kubeconfig .output/_exec_kube_config.yaml
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
