# output

data "template_file" "kube_config" {
  template = "${file("${path.module}/data/kube_config.yaml")}"

  vars {
    CERTIFICATE     = "${aws_eks_cluster.cluster.certificate_authority.0.data}"
    MASTER_ENDPOINT = "${aws_eks_cluster.cluster.endpoint}"
    CLUSTER_NAME    = "${local.lower_name}"
  }
}

data "template_file" "aws_auth" {
  template = "${file("${path.module}/data/aws_auth.yaml")}"

  vars {
    AWS_IAM_ROLE_ARN = "${aws_iam_role.worker.arn}"
  }
}

data "template_file" "aws_ebs_gp2" {
  template = "${file("${path.module}/data/aws_ebs_gp2.yaml")}"
}

resource "local_file" "kube_config" {
  content  = "${data.template_file.kube_config.rendered}"
  filename = "${path.cwd}/.output/kube_config.yaml"
}

resource "local_file" "aws_auth" {
  content  = "${data.template_file.aws_auth.rendered}"
  filename = "${path.cwd}/.output/aws_auth.yaml"
}

resource "local_file" "aws_ebs_gp2" {
  content  = "${data.template_file.aws_ebs_gp2.rendered}"
  filename = "${path.cwd}/.output/aws_ebs_gp2.yaml"
}

locals {
  config = <<EOF

# regign
aws configure set default.region ${var.region}

# kube config
mkdir -p ~/.kube && cat .output/kube_config.yaml > ~/.kube/config

# aws auth
kubectl apply -f .output/aws_auth.yaml

# aws ebs gp2
kubectl apply -f .output/aws_ebs_gp2.yaml

# get
kubectl get node -o wide
kubectl get deploy,pod,svc,ing --all-namespaces

EOF
}

output "config" {
  value = "${local.config}"
}
