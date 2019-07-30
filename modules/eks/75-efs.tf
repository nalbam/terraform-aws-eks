# efs

resource "aws_efs_file_system" "efs" {
  count = var.launch_efs_enable ? 1 : 0

  creation_token = local.full_name

  tags = {
    "Name"                                      = "efs.${local.full_name}"
    "KubernetesCluster"                         = local.full_name
    "kubernetes.io/cluster/${local.full_name}" = "owned"
  }
}

resource "aws_efs_mount_target" "efs" {
  count = var.launch_efs_enable ? length(var.subnet_ids) : 0

  file_system_id = aws_efs_file_system.efs[0].id

  subnet_id = var.subnet_ids[count.index]

  security_groups = [aws_security_group.efs.id]
}
