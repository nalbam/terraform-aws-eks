# output

output "name" {
  value = "${aws_eks_cluster.cluster.name}"
}

output "endpoint" {
  value = "${aws_eks_cluster.cluster.endpoint}"
}

output "config" {
  value = "${local.config}"
}
