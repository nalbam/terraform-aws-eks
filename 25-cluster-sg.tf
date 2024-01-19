# cluster sg

# https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/sec-group-reqs.html

resource "aws_security_group" "cluster" {
  name        = local.cluster_name
  description = "Cluster communication with Worker Nodes"

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
      "Name" = local.cluster_name
    },
  )
}

resource "aws_security_group_rule" "cluster_worker" {
  description              = format("%s - worker 443", local.cluster_name)
  security_group_id        = aws_security_group.cluster.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "TCP"
  source_security_group_id = aws_security_group.worker.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_sslvpn" {
  count = var.sslvpn_name != "" ? 1 : 0

  description       = format("%s - sslvpn 443", local.cluster_name)
  security_group_id = aws_security_group.cluster.id
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  prefix_list_ids   = data.aws_ec2_managed_prefix_list.sslvpn.*.id
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_prefix_list" {
  count = length(var.allow_prefix_list_ids)

  description       = format("%s - prefix_list 443", local.cluster_name)
  security_group_id = aws_security_group.cluster.id
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  prefix_list_ids   = [var.allow_prefix_list_ids[count.index]]
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_cidr" {
  count = length(var.allow_cidr_cluster)

  description       = format("%s - cidr 443", local.cluster_name)
  security_group_id = aws_security_group.cluster.id
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = [var.allow_cidr_cluster[count.index]]
  type              = "ingress"
}
