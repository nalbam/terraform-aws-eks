# efs

locals {
  efs_name = format("%s-efs", var.name)
}

resource "aws_efs_file_system" "this" {
  count = var.efs_enabled ? 1 : 0

  creation_token = var.name

  tags = merge(
    {
      "Name" = local.efs_name
    },
    local.tags,
  )
}

resource "aws_security_group" "efs" {
  count = var.efs_enabled ? 1 : 0

  name        = local.efs_name
  description = "Security group for efs in the cluster"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = local.efs_name
    },
    local.tags,
  )
}

resource "aws_efs_mount_target" "this" {
  count = var.efs_enabled ? length(var.subnet_ids) : 0

  file_system_id = aws_efs_file_system.this[0].id

  subnet_id = var.subnet_ids[count.index]

  security_groups = [aws_security_group.efs[0].id]
}

resource "aws_security_group_rule" "worker-efs" {
  count = var.efs_enabled ? 1 : 0

  description              = "Allow worker to communicate with efs"
  security_group_id        = aws_security_group.efs[0].id
  source_security_group_id = aws_security_group.worker.id
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "-1"
  type                     = "ingress"
}
