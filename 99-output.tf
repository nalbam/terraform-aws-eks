# output

## cluster

output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "cluster_version" {
  value = aws_eks_cluster.cluster.version
}

output "cluster_certificate_authority" {
  value = data.aws_eks_cluster.cluster.certificate_authority.0.data
}

output "cluster_vpc_config" {
  value = aws_eks_cluster.cluster.vpc_config
}

output "cluster_oidc_arn" {
  value = aws_iam_openid_connect_provider.cluster.arn
}

output "cluster_oidc_url" {
  value = aws_iam_openid_connect_provider.cluster.url
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "cluster_role_name" {
  value = aws_iam_role.cluster.name
}

## worker

output "worker_ami_id" {
  value = data.aws_ami.worker.id
}

output "worker_instance_profile_name" {
  value = aws_iam_instance_profile.worker.name
}

output "worker_role_arn" {
  value = aws_iam_role.worker.arn
}

output "worker_role_name" {
  value = aws_iam_role.worker.name
}

output "worker_security_group" {
  value = aws_security_group.worker.id
}

output "worker_sqs_id" {
  value = aws_sqs_queue.worker.id
}
