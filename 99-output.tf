# output

output "cluster_info" {
  value = local.cluster_info
}

output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "cluster_version" {
  value = aws_eks_cluster.cluster.version
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "cluster_vpc_config" {
  value = aws_eks_cluster.cluster.vpc_config
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "cluster_role_name" {
  value = aws_iam_role.cluster.name
}

output "cluster_oidc_arn" {
  value = aws_iam_openid_connect_provider.cluster.arn
}

output "cluster_oidc_url" {
  value = aws_iam_openid_connect_provider.cluster.url
}

output "worker_security_group" {
  value = aws_security_group.worker.id
}

output "worker_role_arn" {
  value = aws_iam_role.worker.arn
}

output "worker_role_name" {
  value = aws_iam_role.worker.name
}

output "worker_instance_profile_name" {
  value = aws_iam_instance_profile.worker.name
}
