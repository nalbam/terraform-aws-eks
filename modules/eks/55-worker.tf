# eks worker

resource "aws_launch_configuration" "worker" {
  count = var.launch_configuration_enable ? 1 : 0

  name_prefix          = "${local.upper_name}-"
  image_id             = data.aws_ami.worker.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.worker.name
  user_data_base64     = base64encode(local.userdata)

  key_name = var.key_path != "" ? "${local.upper_name}-WORKER" : var.key_name

  associate_public_ip_address = var.associate_public_ip_address

  security_groups = [aws_security_group.worker.id]

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "worker" {
  count = var.launch_configuration_enable ? 1 : 0

  name = local.upper_name

  min_size = var.min
  max_size = var.max

  vpc_zone_identifier = var.subnet_ids

  launch_configuration = aws_launch_configuration.worker[0].id

  tags = concat(
    [
      {
        "key"                 = "asg:lifecycle"
        "value"               = "normal"
        "propagate_at_launch" = true
      },
    ],
    local.worker_tags,
  )
}
