# data

data "aws_availability_zones" "azs" {
}

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.id
}

# data "aws_ami" "worker" {
#   filter {
#     name   = "name"
#     values = ["amazon-eks-node-${var.kubernetes_version}-*"]
#   }
#   owners = ["602401143452"] # Amazon Account ID
#   most_recent = true
# }

# aws_auth_workers
data "template_file" "aws_auth_workers" {
  count    = length(var.workers)
  template = file("${path.module}/templates/aws_auth_workers.yaml.tpl")

  vars = {
    rolearn = var.workers[count.index]
  }
}
