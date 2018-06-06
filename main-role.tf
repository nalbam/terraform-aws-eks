resource "aws_iam_role" "default" {
  name = "${var.name}-${var.stage}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "default-eks-cluster-policy" {
  role       = "${aws_iam_role.default.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "default-eks-service-policy" {
  role       = "${aws_iam_role.default.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}
