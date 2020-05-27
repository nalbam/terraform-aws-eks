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

output "oidc_issuer_arn" {
  value = join("", aws_iam_openid_connect_provider.oidc_provider.*.arn)
}

output "security_group_id" {
  value = aws_security_group.cluster.id
}

output "iam_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "iam_role_name" {
  value = aws_iam_role.cluster.name
}
