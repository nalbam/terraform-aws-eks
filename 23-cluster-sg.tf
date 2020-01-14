# cluster security group

resource "aws_security_group" "cluster" {
  name        = var.config.name
  description = "Cluster communication with nodes"

  vpc_id = var.config.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                     = var.config.name
    "KubernetesCluster"                        = var.config.name
    "kubernetes.io/cluster/${var.config.name}" = "owned"
  }
}

resource "aws_security_group_rule" "cluster-https" {
  description       = "Allow workstation to communicate with the cluster API Server"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = var.config.allow_ip_address
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}
