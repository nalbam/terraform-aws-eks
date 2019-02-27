# locals

locals {
  full_name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"

  upper_name = "${upper(local.full_name)}"

  lower_name = "${lower(local.full_name)}"
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
      value               = "${local.lower_name}"
      propagate_at_launch = true
    },
    {
      key                 = "kubernetes.io/cluster/${local.lower_name}"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "k8s.io/cluster-autoscaler/enabled"
      value               = ""
      propagate_at_launch = true
    },
  ]
}

locals {
  userdata = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority.0.data}' \
  '${local.lower_name}'
EOF
}

locals {
  config = <<EOF
#

name = ${element(concat(aws_eks_cluster.cluster.*.name, list("")), 0)}

efs_id = ${element(concat(aws_efs_file_system.efs.*.id, list("")), 0)}

# kube config
aws eks update-kubeconfig --name ${local.lower_name} --alias ${local.lower_name}

# get
kubectl get node -o wide
kubectl get all --all-namespaces

#
EOF
}
