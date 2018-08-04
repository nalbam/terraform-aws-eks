# output

data "template_file" "kube_config" {
  template = "${file("${path.module}/data/kube_config.yml")}"

  vars {
    CERTIFICATE     = "${aws_eks_cluster.cluster.certificate_authority.0.data}"
    MASTER_ENDPOINT = "${aws_eks_cluster.cluster.endpoint}"
    CLUSTER_NAME    = "${var.name}"
  }
}

resource "local_file" "kube_config" {
  content  = "${data.template_file.kube_config.rendered}"
  filename = "${path.cwd}/.output/kube_config.yml"
}

data "template_file" "aws_auth" {
  template = "${file("${path.module}/data/aws_auth.yml")}"

  vars {
    AWS_IAM_ROLE_ARN = "${aws_iam_role.node.arn}"
  }
}

resource "local_file" "aws_auth" {
  content  = "${data.template_file.aws_auth.rendered}"
  filename = "${path.cwd}/.output/aws_auth.yml"
}

locals {
  config = <<EOF

# regign
aws configure set default.region ${var.region}

# kube config
mkdir -p ~/.kube && cat .output/kube_config.yml > ~/.kube/config

# aws auth
kubectl apply -f .output/aws_auth.yml

# get
kubectl get node
kubectl get deploy,pod,svc,ing --all-namespaces
kubectl get svc,ing -o wide --all-namespaces

EOF
}

output "config" {
  value = "${local.config}"
}
