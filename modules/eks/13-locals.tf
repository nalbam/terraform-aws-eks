# locals

locals {
  full_name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"

  upper_name = upper(local.full_name)

  lower_name = lower(local.full_name)
}

locals {
  worker_tags = [
    {
      key                 = "Name"
      value               = "${local.upper_name}-WORKER"
      propagate_at_launch = true
    },
    {
      key                 = "KubernetesCluster"
      value               = local.lower_name
      propagate_at_launch = true
    },
    {
      key                 = "kubernetes.io/cluster/${local.lower_name}"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "k8s.io/cluster-autoscaler/enabled"
      value               = "true"
      propagate_at_launch = true
    },
  ]
}

locals {
  userdata = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority[0].data}' \
  '${local.lower_name}'
EOF

}

locals {
  config = <<EOF
#

# kube config
aws eks update-kubeconfig --name ${local.lower_name} --alias ${local.lower_name}

# or
mkdir -p ~/.kube && cp .output/kube_config.yaml ~/.kube/config

# files
cat .output/aws_auth.yaml
cat .output/kube_config.yaml

# get
kubectl get node -o wide
kubectl get all --all-namespaces

#
EOF

}
