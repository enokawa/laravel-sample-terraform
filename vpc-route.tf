# Ineternet Gateway
resource "aws_internet_gateway" "sample-igw-01" {
  vpc_id = "${aws_vpc.sample-vpc-01.id}"
  tags = {
    Name = "sample-igw-01"
  }
}


# Nat Gateway
resource "aws_nat_gateway" "sample-natgw-01" {
    allocation_id = "${aws_eip.sample-natgw-01.id}"
    subnet_id = "${aws_subnet.sample-public-a.id}"
}

resource "aws_eip" "sample-natgw-01" {
    vpc = true
    tags = {
      Name = "sample-natgw-01"
    }
}


# Route Table
resource "aws_route_table" "sample-public-rtb-01" {
    vpc_id = "${aws_vpc.sample-vpc-01.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.sample-igw-01.id}"
    }

    tags = {
        Name = "sample-public-rtb-01"
    }
}

resource "aws_route_table" "sample-app-rtb-01" {
    vpc_id = "${aws_vpc.sample-vpc-01.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.sample-natgw-01.id}"
    }

    tags = {
        Name = "sample-app-rtb-01"
    }
}

resource "aws_route_table" "sample-private-rtb-01" {
    vpc_id = "${aws_vpc.sample-vpc-01.id}"

    tags = {
        Name = "sample-private-rtb-01"
    }
}


# Route Table Association
resource "aws_route_table_association" "sample-public-a-rtbassoc" {
    route_table_id = "${aws_route_table.sample-public-rtb-01.id}"
    subnet_id = "${aws_subnet.sample-public-a.id}"
}

resource "aws_route_table_association" "sample-public-c-rtbassoc" {
    route_table_id = "${aws_route_table.sample-public-rtb-01.id}"
    subnet_id = "${aws_subnet.sample-public-c.id}"
}

resource "aws_route_table_association" "sample-app-a-rtbassoc" {
    route_table_id = "${aws_route_table.sample-app-rtb-01.id}"
    subnet_id = "${aws_subnet.sample-app-a.id}"
}

resource "aws_route_table_association" "sample-app-c-rtbassoc" {
    route_table_id = "${aws_route_table.sample-app-rtb-01.id}"
    subnet_id = "${aws_subnet.sample-app-c.id}"
}

resource "aws_route_table_association" "sample-private-a-rtbassoc" {
    route_table_id = "${aws_route_table.sample-private-rtb-01.id}"
    subnet_id = "${aws_subnet.sample-private-a.id}"
}

resource "aws_route_table_association" "sample-private-c-rtbassoc" {
    route_table_id = "${aws_route_table.sample-private-rtb-01.id}"
    subnet_id = "${aws_subnet.sample-private-c.id}"
}
