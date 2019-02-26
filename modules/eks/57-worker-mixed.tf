# eks worker

resource "aws_launch_template" "worker-mixed" {
  count = "${var.launch_template_enable ? length(var.mixed_instances) > 0 ? 1 : 0 : 0}"

  name_prefix   = "${local.upper_name}-MIXED-"
  image_id      = "${data.aws_ami.worker.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${base64encode(local.userdata)}"

  key_name = "${var.key_path != "" ? "${local.upper_name}-WORKER" : "${var.key_name}"}"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_type           = "${var.volume_type}"
      volume_size           = "${var.volume_size}"
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
}

resource "aws_autoscaling_group" "worker-mixed" {
  count = "${var.launch_template_enable ? length(var.mixed_instances) > 0 ? 1 : 0 : 0}"

  name = "${local.upper_name}-MIXED"

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
        launch_template_id = "${aws_launch_template.worker-mixed.id}"
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

      override {
        instance_type = "${var.mixed_instances[2]}"
      }
    }
  }

  tags = "${concat(
    list(
      map("key", "asg:lifecycle", "value", "mixed", "propagate_at_launch", true),
    ),
    local.worker_tags)
  }"
}
