# output

output "id" {
  value = data.aws_eks_cluster.cluster.id
}

output "name" {
  value = data.aws_eks_cluster.cluster.name
}

output "version" {
  value = data.aws_eks_cluster.cluster.version
}

output "endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

# output "certificate_authority" {
#   value = data.aws_eks_cluster.cluster.certificate_authority.0.data
# }

# output "token" {
#   value = data.aws_eks_cluster_auth.cluster.token
# }

output "oidc_issuer" {
  value = data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
  # value = join("", data.aws_eks_cluster.cluster.*.identity.0.oidc.0.issuer)
}

output "oidc_arn" {
  value = element(concat(aws_iam_openid_connect_provider.oidc.*.arn, [""]), 0)
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "cluster_role_name" {
  value = aws_iam_role.cluster.name
}

output "cluster_security_group_id" {
  value = aws_security_group.cluster.id
}

output "worker_ami_id" {
  value = data.aws_ami.worker.id
}

output "worker_role_arn" {
  value = aws_iam_role.worker.arn
}

output "worker_role_name" {
  value = aws_iam_role.worker.name
}

output "worker_security_group_id" {
  value = aws_security_group.worker.id
}

output "efs_id" {
  value = element(concat(aws_efs_file_system.this.*.id, [""]), 0)
}
