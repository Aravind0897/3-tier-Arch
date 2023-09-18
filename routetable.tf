resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "my-route"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-subnet[count.index].id
  route_table_id = aws_route_table.rtb.id
  count = 2
}
resource "aws_default_route_table" "dfltrtb" {
  default_route_table_id = aws_vpc.myvpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "dfltrtb"
  }
}
