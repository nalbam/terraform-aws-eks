# Network

resource "aws_vpc" "default" {
  cidr_block = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}-${var.stage}-vpc"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${var.name}-${var.stage}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.default.id}"

  count = "${length(var.azs)}"
  availability_zone = "${var.azs[count.index]}"

  cidr_block = "${cidrsubnet(aws_vpc.default.cidr_block, 8, 20 + count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-${var.stage}-public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "${var.name}-${var.stage}-public"
  }
}

resource "aws_route_table_association" "public" {
  count = "${length(var.azs)}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
