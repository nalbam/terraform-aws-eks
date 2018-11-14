# worker security group

resource "aws_security_group" "worker" {
  name        = "${local.lower_name}-worker"
  description = "Security group for all worker nodes in the cluster"

  vpc_id = "${aws_vpc.cluster.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "${local.lower_name}-worker",
     "kubernetes.io/cluster/${local.lower_name}", "owned"
    )
  }"
}

resource "aws_security_group_rule" "worker-ingress-self" {
  description              = "Allow worker to communicate with each other"
  security_group_id        = "${aws_security_group.worker.id}"
  source_security_group_id = "${aws_security_group.worker.id}"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  security_group_id        = "${aws_security_group.worker.id}"
  source_security_group_id = "${aws_security_group.cluster.id}"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-ingress-https" {
  description              = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane."
  security_group_id        = "${aws_security_group.worker.id}"
  source_security_group_id = "${aws_security_group.cluster.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  type                     = "ingress"
}
