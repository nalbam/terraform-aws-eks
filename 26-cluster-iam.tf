# cluster iam

data "aws_iam_policy_document" "cluster" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "eks.amazonaws.com",
      ]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "cluster" {
  name = local.cluster_name

  assume_role_policy = data.aws_iam_policy_document.cluster.json

  tags = merge(
    local.tags,
    {
      "Name" = local.cluster_name
    },
  )
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSServicePolicy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}
