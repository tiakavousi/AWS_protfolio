# Subnets
resource "aws_subnet" "private-a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block[0]
  availability_zone = var.availability_zone[0]

  tags = {
    "Name"      = "private-a"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block[1]
  availability_zone = var.availability_zone[1]

  tags = {
    "Name"      = "private-b"
  }
}

resource "aws_subnet" "public-a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block[2]
  availability_zone       = var.availability_zone[2]
  map_public_ip_on_launch = true

  tags = {
    "Name"      = "public-a"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block[3]
  availability_zone       = var.availability_zone[3]
  map_public_ip_on_launch = true

  tags = {
    "Name"      = "public-b"
  }
}
