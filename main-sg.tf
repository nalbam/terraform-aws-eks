
resource "aws_security_group" "self" {
  name = "${var.name}-${var.stage}-self"
  description = "for ${var.name}-${var.stage}-vpc"

  vpc_id = "${aws_vpc.default.id}"

  # SELF
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # ensure the VPC has an Internet gateway or this step will fail
  depends_on = [
    "aws_internet_gateway.default"
  ]
}

resource "aws_security_group" "all" {
  name = "${var.name}-${var.stage}-all"
  description = "for ${var.name}-${var.stage}-vpc"

  vpc_id = "${aws_vpc.default.id}"

  # ALL
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # ALL
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # ensure the VPC has an Internet gateway or this step will fail
  depends_on = [
    "aws_internet_gateway.default"
  ]
}
