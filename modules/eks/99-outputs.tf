# output

output "name" {
  value = "${element(concat(aws_eks_cluster.cluster.*.name, list("")), 0)}"
}

output "endpoint" {
  value = "${element(concat(aws_eks_cluster.cluster.*.endpoint, list("")), 0)}"
}

output "config" {
  value = "${local.config}"
}

output "worker_sg_id" {
  value = "${element(concat(aws_security_group.worker.*.id, list("")), 0)}"
}

output "efs_id" {
  value = "${element(concat(aws_efs_file_system.efs.*.id, list("")), 0)}"
}
