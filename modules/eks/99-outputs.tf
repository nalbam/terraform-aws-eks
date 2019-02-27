# output

output "name" {
  value = "${element(concat(aws_eks_cluster.cluster.*.name, list("")), 0)}"
}

output "config" {
  value = "${local.config}"
}

output "efs_id" {
  value = "${element(concat(aws_efs_file_system.efs.*.id, list("")), 0)}"
}
