# cluster security group

resource "aws_security_group" "cluster" {
  name        = var.name
  description = "Cluster communication with nodes"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      "kubernetes.io/cluster/${var.name}" = "owned"
    },
  )
}

resource "aws_security_group_rule" "cluster-https" {
  count             = length(var.allow_ip_address) > 0 ? 1 : 0
  description       = "Allow workstation to communicate with the cluster API Server"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = var.allow_ip_address
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  type              = "ingress"
}
