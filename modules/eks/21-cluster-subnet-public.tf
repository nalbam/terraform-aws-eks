# cluster subnet public

resource "aws_subnet" "public" {
  count      = "${local.az_count}"
  vpc_id     = "${data.aws_vpc.cluster.id}"
  cidr_block = "${cidrsubnet(data.aws_vpc.cluster.cidr_block, 4, count.index)}"

  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"

  tags = "${
    map(
     "Name", "${var.city}-${upper(element(split("", data.aws_availability_zones.azs.names[count.index]), length(data.aws_availability_zones.azs.names[count.index])-1))}-${var.stage}-${var.name}-${var.suffix}-PUBLIC",
     "kubernetes.io/cluster/${local.lower_name}", "shared"
    )
  }"
}

resource "aws_route_table" "public" {
  vpc_id = "${data.aws_vpc.cluster.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.cluster.id}"
  }

  tags {
    Name = "${local.full_name}-PUBLIC"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${local.az_count}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}
