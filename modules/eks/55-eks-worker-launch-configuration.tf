# eks worker

resource "aws_launch_configuration" "worker" {
  count = "${var.launch_configuration_enable ? 1 : 0}"

  name_prefix          = "${local.lower_name}-"
  image_id             = "${data.aws_ami.worker.id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.worker.name}"
  user_data_base64     = "${base64encode(local.userdata)}"

  key_name = "${var.key_path != "" ? "${local.lower_name}-worker" : "${var.key_name}"}"

  security_groups = ["${aws_security_group.worker.id}"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "128"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "worker-lc" {
  count = "${var.launch_configuration_enable ? 1 : 0}"

  name = "${local.lower_name}-lc"

  min_size = "${var.min}"
  max_size = "${var.max}"

  vpc_zone_identifier = ["${var.subnet_ids}"]

  launch_configuration = "${aws_launch_configuration.worker.id}"

  tag {
    key                 = "Name"
    value               = "${local.lower_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "launch_type"
    value               = "lc"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${local.lower_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = ""
    propagate_at_launch = true
  }
}
