# cluster vpc

resource "aws_vpc" "cluster" {
  cidr_block = "${var.cidr_block}"

  tags = "${
    map(
     "Name", "${local.lower_name}",
     "kubernetes.io/cluster/${local.lower_name}", "shared"
    )
  }"
}
