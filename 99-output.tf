# output

output "name" {
  value = aws_eks_cluster.cluster.name
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "certificate_authority" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "security_group_id" {
  value = aws_security_group.cluster.id
}

output "role_arn" {
  value = aws_iam_role.cluster.arn
}

output "version" {
  value = aws_eks_cluster.cluster.version
}
