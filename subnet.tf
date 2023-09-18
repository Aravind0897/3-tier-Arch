resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr[count.index]
  availability_zone = var.az[count.index]
  count = 2

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "pri-subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-subnet"
  }
}
data "aws_subnets" "sid" {
 filter {
   name = "vpc-id"
   values = [aws_vpc.myvpc.id]
}

 tags = {
    tier = "public"
  }
}
