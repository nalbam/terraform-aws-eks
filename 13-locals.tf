# locals

locals {
  account_id = data.aws_caller_identity.current.account_id
}

locals {
  user_data = <<EOF
#!/bin/bash -xe
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority[0].data}' \
  '${var.name}'
EOF

}
