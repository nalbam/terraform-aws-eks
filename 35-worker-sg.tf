# worker sg

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

  tags = merge(
    local.tags,
    {
      "Name" = local.worker_name
    },
  )
}

resource "aws_security_group_rule" "worker_cluster" {
  type                     = "ingress"
  description              = format("%s - cluster 1025-65535", local.worker_name)
  security_group_id        = aws_security_group.worker.id
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.cluster.id
}

resource "aws_security_group_rule" "worker_cluster_443" {
  type                     = "ingress"
  description              = format("%s - cluster 443", local.worker_name)
  security_group_id        = aws_security_group.worker.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.cluster.id
}

resource "aws_security_group_rule" "worker_worker" {
  type                     = "ingress"
  description              = format("%s - worker all", local.worker_name)
  security_group_id        = aws_security_group.worker.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.worker.id
}

resource "aws_security_group_rule" "worker_source" {
  count = length(var.worker_source_sgs)

  type                     = "ingress"
  description              = format("%s - worker source", local.worker_name)
  security_group_id        = aws_security_group.worker.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.worker_source_sgs[count.index]
}

resource "aws_security_group_rule" "worker_prefix_list" {
  count = length(var.allow_prefix_list_ids)

  type              = "ingress"
  description       = format("%s - prefix_list", local.worker_name)
  security_group_id = aws_security_group.worker.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = [var.allow_prefix_list_ids[count.index]]
}

resource "aws_security_group_rule" "worker_ports_internal" {
  count = length(var.worker_ports_internal)

  type              = "ingress"
  description       = format("%s - internal ports (%s)", local.worker_name, var.worker_ports_internal[count.index])
  security_group_id = aws_security_group.worker.id
  from_port         = var.worker_ports_internal[count.index]
  to_port           = var.worker_ports_internal[count.index]
  protocol          = "TCP"
  cidr_blocks       = var.allow_cidr_internal
}

resource "aws_security_group_rule" "worker_ports_public" {
  count = length(var.worker_ports_public)

  type              = "ingress"
  description       = format("%s - public ports (%s)", local.worker_name, var.worker_ports_public[count.index])
  security_group_id = aws_security_group.worker.id
  from_port         = var.worker_ports_public[count.index]
  to_port           = var.worker_ports_public[count.index]
  protocol          = "TCP"
  cidr_blocks       = var.allow_cidr_public
}
