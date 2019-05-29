# eks worker

resource "aws_launch_template" "worker-spot" {
  count = var.launch_template_enable ? length(var.mixed_instances) == 0 ? 1 : 0 : 0

  name_prefix   = "${local.upper_name}-SPOT-"
  image_id      = data.aws_ami.worker.id
  instance_type = var.instance_type
  user_data     = base64encode(local.userdata)

  key_name = var.key_path != "" ? "${local.upper_name}-WORKER" : var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = var.volume_type
      volume_size           = var.volume_size
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.worker.name
  }

  network_interfaces {
    delete_on_termination       = true
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = [aws_security_group.worker.id]
  }

  instance_market_options {
    market_type = "spot"
  }
}

resource "aws_autoscaling_group" "worker-spot" {
  count = var.launch_template_enable ? length(var.mixed_instances) == 0 ? 1 : 0 : 0

  name = "${local.upper_name}-SPOT"

  min_size = var.min
  max_size = var.max

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.worker-spot[0].id
    version = "$Latest"
  }

  tags = concat(
    [
      {
        "key"                 = "asg:lifecycle"
        "value"               = "spot"
        "propagate_at_launch" = true
      },
    ],
    local.worker_tags,
  )
}
