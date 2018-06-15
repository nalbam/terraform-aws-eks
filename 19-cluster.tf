# Terraform Main

resource "aws_eks_cluster" "cluster" {
  name     = "${var.name}"
  role_arn = "${aws_iam_role.cluster.arn}"

  vpc_config {
    subnet_ids         = ["${aws_subnet.cluster.*.id}"],
    security_group_ids = ["${aws_security_group.cluster.id}"],
  }

  depends_on = [
    "aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.cluster-AmazonEKSServicePolicy",
  ]
}
