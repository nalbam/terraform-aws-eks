# eks worker

data "aws_ami" "worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-v*"]
  }

  owners = ["602401143452"] # Amazon Account ID

  most_recent = true
}

locals {
  userdata = <<EOF
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh \
  --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' \
  --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority.0.data}' \
  '${local.lower_name}'
EOF
}

resource "aws_launch_configuration" "worker" {
  name_prefix                 = "${local.lower_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.worker.name}"
  image_id                    = "${data.aws_ami.worker.id}"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${aws_security_group.worker.id}"]
  user_data_base64            = "${base64encode(local.userdata)}"
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "worker" {
  name                 = "${local.lower_name}"
  desired_capacity     = "${var.desired}"
  min_size             = "${var.min}"
  max_size             = "${var.max}"
  vpc_zone_identifier  = ["${aws_subnet.public.*.id}"]
  launch_configuration = "${aws_launch_configuration.worker.id}"

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
