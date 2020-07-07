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

output "certificate_authority" {
  value = data.aws_eks_cluster.cluster.certificate_authority.0.data
}

# output "token" {
#   value = data.aws_eks_cluster_auth.cluster.token
# }

output "oidc_issuer" {
  value = join("", data.aws_eks_cluster.cluster.*.identity.0.oidc.0.issuer)
}

output "oidc_arn" {
  value = join("", aws_iam_openid_connect_provider.cluster.*.arn)
}

output "security_group_id" {
  value = aws_security_group.cluster.id
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "worker_role_arn" {
  value = aws_iam_role.worker.arn
}
