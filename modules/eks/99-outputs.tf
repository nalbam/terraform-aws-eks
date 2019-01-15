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

output "vpc_id" {
  value = "${data.aws_vpc.cluster.id}"
}

output "subnet_public_ids" {
  value = "${aws_subnet.public.*.id}"
}

output "subnet_private_ids" {
  value = "${aws_subnet.private.*.id}"
}
