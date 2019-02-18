# eks worker

resource "aws_launch_template" "worker" {
  count = "${var.launch_template_enable ? 1 : 0}"

  name_prefix   = "${local.lower_name}-"
  image_id      = "${data.aws_ami.worker.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${base64encode(local.userdata)}"

  key_name = "${var.key_path != "" ? "${local.lower_name}-worker" : "${var.key_name}"}"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = "gp2"
      volume_size           = "128"
      delete_on_termination = true
    }
  }

  iam_instance_profile {
    name = "${aws_iam_instance_profile.worker.name}"
  }

  network_interfaces {
    delete_on_termination = true
    security_groups       = ["${aws_security_group.worker.id}"]
  }

  instance_market_options {
    market_type = "spot"
  }
}

resource "aws_autoscaling_group" "worker-lt" {
  count = "${var.launch_template_enable ? length(var.mixed_instances) != 2 ? 1 : 0 : 0}"

  name = "${local.lower_name}-lt"

  min_size = "${var.min}"
  max_size = "${var.max}"

  vpc_zone_identifier = ["${var.subnet_ids}"]

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
    key                 = "launch_type"
    value               = "lt"
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

resource "aws_autoscaling_group" "worker-lt-mixed" {
  count = "${var.launch_template_enable ? length(var.mixed_instances) == 2 ? 1 : 0 : 0}"

  name = "${local.lower_name}-lt-mixed"

  min_size = "${var.min}"
  max_size = "${var.max}"

  vpc_zone_identifier = ["${var.subnet_ids}"]

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = "${var.on_demand_base}"
      on_demand_percentage_above_base_capacity = "${var.on_demand_rate}"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.worker.id}"
        version            = "$$Latest"
      }

      override {
        instance_type = "${var.instance_type}"
      }

      # https://github.com/hashicorp/terraform/issues/7034#issuecomment-433511035
      override {
        instance_type = "${var.mixed_instances[0]}"
      }

      override {
        instance_type = "${var.mixed_instances[1]}"
      }
    }
  }

  tag {
    key                 = "Name"
    value               = "${local.lower_name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "launch_type"
    value               = "lt"
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
