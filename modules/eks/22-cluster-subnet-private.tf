# subnet private

resource "aws_subnet" "private" {
  count      = "${local.az_count}"
  vpc_id     = "${data.aws_vpc.cluster.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.cluster.cidr_block, 8, 20 + count.index)}"

  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"

  tags = "${
    map(
     "Name", "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1))}-${var.stage}-${var.name}-${var.suffix}-PRIVATE",
     "kubernetes.io/cluster/${local.lower_name}", "shared"
    )
  }"
}

resource "aws_eip" "private" {
  count      = "${local.az_count}"
  vpc        = true
  depends_on = ["aws_route_table.public"]

  tags = "${
    map(
     "Name", "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1))}-${var.stage}-${var.name}-${var.suffix}-PRIVATE",
     "kubernetes.io/cluster/${local.lower_name}", "shared"
    )
  }"
}

resource "aws_nat_gateway" "private" {
  count         = "${local.az_count}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  allocation_id = "${element(aws_eip.private.*.id, count.index)}"
}

resource "aws_route_table" "private" {
  count  = "${local.az_count}"
  vpc_id = "${data.aws_vpc.cluster.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.private.*.id, count.index)}"
  }

  tags = "${
    map(
     "Name", "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1))}-${var.stage}-${var.name}-${var.suffix}-PRIVATE",
     "kubernetes.io/cluster/${local.lower_name}", "shared"
    )
  }"
}

resource "aws_route_table_association" "private" {
  count          = "${local.az_count}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
