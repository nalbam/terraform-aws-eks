# local exec

# resource "null_resource" "aws_auth" {
#   provisioner "local-exec" {
#     working_dir = path.module

#     command = <<EOS
# echo "${null_resource.aws_auth.triggers.aws_auth}" > aws_auth.yaml & \
# echo "${null_resource.aws_auth.triggers.kube_config}" > kube_config.yaml & \
# for i in `seq 1 10`; do \
#   kubectl apply -f aws_auth.yaml --kubeconfig kube_config.yaml && break || sleep 10; \
# done; \
# rm -rf aws_auth.yaml kube_config.yaml
# EOS

#     interpreter = var.config.local_exec_interpreter
#   }

#   depends_on = [aws_eks_cluster.cluster]

#   triggers = {
#     aws_auth    = data.template_file.aws_auth.rendered
#     kube_config = data.template_file.kube_config.rendered
#   }
# }

# resource "null_resource" "kube_config" {
#   count = length(var.config.clusters) > 0 ? length(var.config.clusters) : 1

#   provisioner "local-exec" {
#     working_dir = path.module

#     command = <<EOS
# aws eks update-kubeconfig --name ${var.config.name} --alias ${var.config.name}
# EOS

#     interpreter = var.config.local_exec_interpreter
#   }

#   depends_on = [aws_eks_cluster.cluster]

#   triggers = {
#     endpoint = aws_eks_cluster.cluster.endpoint
#   }
# }
