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

  tags = merge(
    local.tags,
    {
      "Name" = local.worker_name
    },
  )
}

resource "aws_iam_instance_profile" "worker" {
  name = local.worker_name
  role = aws_iam_role.worker.name

  tags = merge(
    local.tags,
    {
      "Name" = local.worker_name
    },
  )
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

# worker_policies

resource "aws_iam_role_policy_attachment" "worker_policies" {
  count = length(var.worker_policies)

  role       = aws_iam_role.worker.name
  policy_arn = var.worker_policies[count.index]
}

# worker_ssm_access

data "aws_iam_policy" "worker_ssm_access" {
  count = var.ssm_policy_name != "" ? 1 : 0

  name = var.ssm_policy_name
}

resource "aws_iam_role_policy_attachment" "worker_ssm_access" {
  count = var.ssm_policy_name != "" ? 1 : 0

  role       = aws_iam_role.worker.name
  policy_arn = data.aws_iam_policy.worker_ssm_access.0.arn
}

# worker_create_tags

resource "aws_iam_policy" "worker_create_tags" {
  name = format("%s-create-tags", local.worker_name)

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:CreateTags",
        "ssm:GetParameter"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  tags = merge(
    local.tags,
    {
      "Name" = format("%s-create-tags", local.worker_name)
    },
  )
}

resource "aws_iam_role_policy_attachment" "worker_create_tags" {
  role       = aws_iam_role.worker.name
  policy_arn = aws_iam_policy.worker_create_tags.arn
}
