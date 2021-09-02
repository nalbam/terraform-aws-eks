resource "aws_security_group" "worker" {
  name        = local.worker_name
  description = "EKS worker node common security_group"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = local.worker_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker_cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_cluster_443" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_cluster_10250" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_worker" {
  description              = "Allow to communicate between worker nodes"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.worker.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_ssh" {
  description       = "SSH via VPN"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.worker.id
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/8"]
  type              = "ingress"
}
