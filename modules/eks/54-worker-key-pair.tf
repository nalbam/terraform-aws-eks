# worker key pair

resource "aws_key_pair" "worker" {
  count      = var.key_path != "" ? 1 : 0
  key_name   = "${local.full_name}-worker"
  public_key = file(var.key_path)
}
