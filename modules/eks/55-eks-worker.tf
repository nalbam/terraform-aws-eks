# eks worker

resource "aws_key_pair" "worker" {
  count      = "${var.key_path != "" ? 1 : 0}"
  key_name   = "${local.lower_name}-worker"
  public_key = "${file(var.key_path)}"
}

resource "aws_launch_configuration" "worker" {
  name_prefix          = "${local.lower_name}"
  image_id             = "${data.aws_ami.worker.id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.worker.name}"
  user_data_base64     = "${base64encode(local.userdata)}"

  key_name = "${var.key_path != "" ? "${local.lower_name}-worker" : "${var.key_name}"}"

  associate_public_ip_address = true

  security_groups = ["${aws_security_group.worker.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "worker" {
  name_prefix   = "${local.lower_name}"
  image_id      = "${data.aws_ami.worker.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${base64encode(local.userdata)}"

  key_name = "${var.key_path != "" ? "${local.lower_name}-worker" : "${var.key_name}"}"

  iam_instance_profile {
    name = "${aws_iam_instance_profile.worker.name}"
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = ["${aws_security_group.worker.id}"]
  }
  instance_market_options {
    market_type = "spot"
  }
}

resource "aws_autoscaling_group" "worker" {
  name                = "${local.lower_name}"
  desired_capacity    = "${var.desired}"
  min_size            = "${var.min}"
  max_size            = "${var.max}"
  vpc_zone_identifier = ["${aws_subnet.public.*.id}"]

  # launch_configuration = "${aws_launch_configuration.worker.id}"

  launch_template = {
    id      = "${aws_launch_template.worker.id}"
    version = "$$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${local.lower_name}"
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
