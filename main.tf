# Terraform Main

resource "aws_eks_cluster" "demo" {
  name     = "${var.name}-${var.stage}"
  role_arn = "${aws_iam_role.default.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.public.*.id}"],
//    security_group_ids = [],
  }

  depends_on = [
    "aws_iam_role_policy_attachment.default-eks-cluster-policy",
    "aws_iam_role_policy_attachment.default-eks-service-policy",
  ]
}
