# cluster vpc

resource "aws_vpc" "cluster" {
  cidr_block = "${var.cidr_block}"

  tags = "${
    map(
     "Name", "tf-eks-${var.name}",
     "kubernetes.io/cluster/${var.name}", "shared"
    )
  }"
}
