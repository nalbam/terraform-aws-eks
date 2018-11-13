# cluster subnet public

resource "aws_subnet" "public" {
  count      = "${length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)}"
  vpc_id     = "${aws_vpc.cluster.id}"
  cidr_block = "${cidrsubnet(aws_vpc.cluster.cidr_block, 8, 10 + count.index)}"

  availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"

  tags = "${
    map(
     "Name", "${local.lower_name}-public",
     "kubernetes.io/cluster/${local.lower_name}", "shared"
    )
  }"
}

resource "aws_internet_gateway" "public" {
  vpc_id = "${aws_vpc.cluster.id}"

  tags {
    Name = "${local.lower_name}-public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.cluster.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags {
    Name = "${local.lower_name}-public"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(data.aws_availability_zones.azs.names) > 3 ? 3 : length(data.aws_availability_zones.azs.names)}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}
