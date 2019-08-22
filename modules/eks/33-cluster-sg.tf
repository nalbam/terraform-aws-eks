# cluster security group

resource "aws_security_group" "cluster" {
  name        = "masters.${local.full_name}"
  description = "Cluster communication with worker nodes"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                     = "masters.${local.full_name}"
    "KubernetesCluster"                        = local.full_name
    "kubernetes.io/cluster/${local.full_name}" = "owned"
  }
}

resource "aws_security_group_rule" "cluster-worker" {
  description              = "Allow node to communicate with the cluster API Server"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = module.worker.security_group_id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster-https" {
  description       = "Allow workstation to communicate with the cluster API Server"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = var.allow_ip_address
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}
