resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = var.vpc_name
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

   tags = {
    Name        = var.igw_name
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidr_block
  availability_zone       = var.availability_zones
  map_public_ip_on_launch = true
  
  tags = {
    Name        =( "${var.public_subnet_name}")
  }

  
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.RT_public_subnet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route_table" "RT_public_subnet" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.RTname}-public-route-table_subnet"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.RT_public_subnet.id
}