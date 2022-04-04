resource "aws_security_group" "worker" {
  name        = local.worker_name
  description = "EKS worker node common security_group"

  vpc_id = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = var.ip_family == "ipv6" ? ["::/0"] : null
  }

  tags = {
    "Name"                                      = local.worker_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker_cluster" {
  description              = format("Allow to communicate between master and workers (%s)", local.worker_name)
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_cluster_443" {
  description              = format("Allow to communicate between master and workers (%s)", local.worker_name)
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_cluster_10250" {
  description              = format("Allow to communicate between master and workers (%s)", local.worker_name)
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.cluster.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_worker" {
  description              = format("Allow to communicate between workers (%s)", local.worker_name)
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = aws_security_group.worker.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_ssh" {
  description       = format("Allow to communicate between ssh and workers (%s)", local.worker_name)
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.worker.id
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/8"]
  type              = "ingress"
}

resource "aws_security_group_rule" "worker_source" {
  count = length(var.worker_source_sgs)

  description              = format("Allow to communicate between source and workers (%s)", local.worker_name)
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker.id
  source_security_group_id = var.worker_source_sgs[count.index]
  type                     = "ingress"
}
