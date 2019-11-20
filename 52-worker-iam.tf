# worker iam role

resource "aws_iam_role_policy_attachment" "worker-AmazonEKS_CNI_Policy" {
  role       = module.worker.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEKSWorkerNodePolicy" {
  role       = module.worker.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "worker-AmazonEC2ContainerRegistryReadOnly" {
  role       = module.worker.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy" "worker_kube2iam" {
  name   = "EKSNodeKube2IAMPolicy"
  role   = module.worker.iam_role_name
  policy = data.aws_iam_policy_document.worker_kube2iam.json
}

data "aws_iam_policy_document" "worker_kube2iam" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}
