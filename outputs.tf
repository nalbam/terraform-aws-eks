locals {
  kube-config = <<KUBECONFIG

apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.demo.endpoint}
    certificate-authority-data: ${aws_eks_cluster.demo.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "${var.name}-${var.stage}"
        # - "-r"
        # - "<role-arn>"

KUBECONFIG
}

output "kube-config" {
  value = "${local.kube-config}"
}

output "endpoint" {
  value = "${aws_eks_cluster.demo.endpoint}"
}

//output "kubeconfig-certificate-authority-data" {
//  value = "${aws_eks_cluster.demo.certificate_authority.0.data}"
//}
