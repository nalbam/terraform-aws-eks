# eks worker

resource "aws_launch_configuration" "node" {
  name_prefix                 = "tf-eks-${var.name}"
  iam_instance_profile        = "${aws_iam_instance_profile.node.name}"
  image_id                    = "${data.aws_ami.worker.id}"
  instance_type               = "${var.node_type}"
  security_groups             = ["${aws_security_group.node.id}"]
  user_data_base64            = "${base64encode(local.userdata)}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "node" {
  name                 = "tf-eks-${var.name}"
  desired_capacity     = "${var.desired}"
  min_size             = "${var.min}"
  max_size             = "${var.max}"
  vpc_zone_identifier  = ["${aws_subnet.public.*.id}"]
  launch_configuration = "${aws_launch_configuration.node.id}"

  tag {
    key                 = "Name"
    value               = "tf-eks-${var.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
