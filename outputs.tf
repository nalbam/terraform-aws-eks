data "template_file" "aws-auth" {
  template = "${file("${path.cwd}/data/aws-auth.yml")}"
  vars {
    AWS_IAM_ROLE_ARN = "${aws_iam_role.node.arn}"
  }
}
resource "local_file" "aws-auth" {
  content = "${data.template_file.aws-auth.rendered}"
  filename = "${path.cwd}/.output/aws-auth.yml"
}

data "template_file" "kube-config" {
  template = "${file("${path.cwd}/data/kube-config.yml")}"
  vars {
    CERTIFICATE = "${aws_eks_cluster.cluster.certificate_authority.0.data}"
    MASTER_ENDPOINT = "${aws_eks_cluster.cluster.endpoint}"
    CLUSTER_NAME = "${var.name}"
  }
}
resource "local_file" "kube-config" {
  content = "${data.template_file.kube-config.rendered}"
  filename = "${path.cwd}/.output/kube-config.yml"
}

locals {
  config = <<EOF

# kube-config
mkdir -p ~/.kube && cat .output/kube-config.yml > ~/.kube/config

# aws-auth
kubectl apply -f .output/aws-auth.yml

# calico
kubectl apply -f ./data/calico.yml

# sample
kubectl apply -f ./data/sample-web.yml

# get
kubectl get no,deploy,pod,svc --all-namespaces

EOF
}

output "config" {
  value = "${local.config}"
}
