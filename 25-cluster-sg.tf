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
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    "Name"                                      = local.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "cluster_worker" {
  description              = "Allow workers to communicate with the cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.worker.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_vpn" {
  description       = "Allow vpn to communicate with the cluster API Server"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = ["10.0.0.0/8"]
  type              = "ingress"
}

resource "aws_security_group_rule" "cluster_sslvpn" {
  count = var.sslvpn_name != "" ? 1 : 0

  description       = "Allow sslvpn to communicate with the cluster API Server"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  prefix_list_ids   = data.aws_ec2_managed_prefix_list.sslvpn.*.id
  type              = "ingress"
}
