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

output "worker_sg_id" {
  value = "${aws_security_group.worker.id}"
}
