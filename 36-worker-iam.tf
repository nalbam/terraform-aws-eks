# worker iam

data "aws_iam_policy_document" "worker" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "worker" {
  name = local.worker_name

  assume_role_policy = data.aws_iam_policy_document.worker.json
}

resource "aws_iam_instance_profile" "worker" {
  name = local.worker_name
  role = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "worker_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "worker_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "worker_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.worker.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "worker_policies" {
  count = length(var.worker_policies)

  role       = aws_iam_role.worker.name
  policy_arn = var.worker_policies[count.index]
}

data "aws_iam_policy" "ssm_policy" {
  count = var.ssm_policy_name != "" ? 1 : 0

  name = var.ssm_policy_name
}

resource "aws_iam_role_policy_attachment" "worker_ssm_access" {
  count = var.ssm_policy_name != "" ? 1 : 0

  role       = aws_iam_role.worker.name
  policy_arn = data.aws_iam_policy.ssm_policy.0.arn
}
