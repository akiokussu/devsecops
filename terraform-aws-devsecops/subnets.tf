resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.devsecops_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.devsecops_vpc.id
  cidr_block        = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "eu-central-1a"

  tags = {
    Name = "PrivateSubnet"
  }
}
