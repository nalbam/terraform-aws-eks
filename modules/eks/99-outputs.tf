# output

output "config" {
  value = "${local.config}"
}

output "name" {
  value = "${aws_eks_cluster.cluster.*.name}"
}

output "efs_id" {
  value = "${aws_efs_file_system.efs.*.id}"
}

output "buckets" {
  value = "${aws_s3_bucket.buckets.*.bucket}"
}
