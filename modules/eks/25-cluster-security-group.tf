# cluster security group

resource "aws_security_group" "cluster" {
  name        = "tf-eks-${var.name}-cluster"
  description = "Cluster communication with worker nodes"

  vpc_id = "${aws_vpc.cluster.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "tf-eks-${var.name}-cluster"
  }
}

resource "aws_security_group_rule" "cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  security_group_id        = "${aws_security_group.cluster.id}"
  source_security_group_id = "${aws_security_group.node.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  type                     = "ingress"
}

# OPTIONAL: Allow inbound traffic from your local workstation external IP
#           to the Kubernetes. You will need to replace A.B.C.D below with
#           your real IP. Services like icanhazip.com can help you find this.
//resource "aws_security_group_rule" "cluster-ingress-workstation-https" {
//  cidr_blocks       = ["A.B.C.D/32"]
//  description       = "Allow workstation to communicate with the cluster API Server"
//  security_group_id = "${aws_security_group.cluster.id}"
//  from_port         = 443
//  to_port           = 443
//  protocol          = "tcp"
//  type              = "ingress"
//}
