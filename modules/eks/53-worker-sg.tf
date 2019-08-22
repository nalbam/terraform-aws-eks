# worker security group

# resource "aws_security_group" "worker" {
#   name        = "nodes.${local.full_name}"
#   description = "Security group for all worker nodes in the cluster"

#   vpc_id = var.vpc_id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     "Name"                                     = "nodes.${local.full_name}"
#     "KubernetesCluster"                        = local.full_name
#     "kubernetes.io/cluster/${local.full_name}" = "owned"
#   }
# }

resource "aws_security_group_rule" "worker-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  security_group_id        = module.worker.security_group_id
  source_security_group_id = aws_security_group.cluster.id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-worker" {
  description              = "Allow worker to communicate with each other"
  security_group_id        = module.worker.security_group_id
  source_security_group_id = module.worker.security_group_id
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-ssh" {
  description       = "Allow workstation to communicate with the cluster API Server"
  security_group_id = module.worker.security_group_id
  cidr_blocks       = var.allow_ip_address
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  type              = "ingress"
}
