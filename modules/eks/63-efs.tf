# efs

resource "aws_efs_file_system" "efs" {
  count = var.launch_efs_enable ? 1 : 0

  creation_token = var.name

  tags = {
    "Name"                              = "efs.${var.name}"
    "KubernetesCluster"                 = var.name
    "kubernetes.io/cluster/${var.name}" = "owned"
  }
}

resource "aws_efs_mount_target" "efs" {
  count = var.launch_efs_enable ? length(var.subnet_ids) : 0

  file_system_id = aws_efs_file_system.efs[0].id

  subnet_id = var.subnet_ids[count.index]

  security_groups = [aws_security_group.efs.id]
}

resource "aws_security_group" "efs" {
  name        = "efs.${var.name}"
  description = "Security group for efs in the cluster"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                              = "efs.${var.name}"
    "KubernetesCluster"                 = var.name
    "kubernetes.io/cluster/${var.name}" = "owned"
  }
}

resource "aws_security_group_rule" "efs-worker" {
  description              = "Allow worker to communicate with each other"
  security_group_id        = aws_security_group.efs.id
  source_security_group_id = module.worker.security_group_id
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "-1"
  type                     = "ingress"
}
