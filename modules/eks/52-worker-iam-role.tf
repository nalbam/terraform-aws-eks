# worker iam role

resource "aws_iam_role" "worker" {
  name = "${local.upper_name}-WORKER"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "worker" {
  name = "${local.upper_name}-WORKER"
  role = "${aws_iam_role.worker.name}"
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEKS_CNI_Policy" {
  role       = "${aws_iam_role.worker.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEKSWorkerNodePolicy" {
  role       = "${aws_iam_role.worker.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEC2ContainerRegistryReadOnly" {
  role       = "${aws_iam_role.worker.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "worker-AutoScalingFullAccess" {
  role       = "${aws_iam_role.worker.name}"
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
}

# resource "aws_iam_role_policy_attachment" "worker-AmazonS3FullAccess" {
#   role       = "${aws_iam_role.worker.name}"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }
