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

# resource "aws_iam_role_policy_attachment" "worker-AmazonS3FullAccess" {
#   role       = "${module.worker.iam_role_name}"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }
