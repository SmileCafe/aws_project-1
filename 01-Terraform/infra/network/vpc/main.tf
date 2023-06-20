resource "aws_vpc" "aws08-vpc" {
	cidr_block = var.vpc_cidr
	enable_dns_hostnames = true
	enable_dns_support = true
	instance_tenancy = "default"

	tags = {
		Name = "aws08-vpc"
	}
}

# Public Subnet 2a
resource "aws_subnet" "aws08-public-subnet2a" {
	vpc_id = aws_vpc.aws08-vpc.id
	cidr_block = var.public_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "aws08-public-subnet2a"
	}
}

# Public Subnet 2c
resource "aws_subnet" "aws08-public-subnet2c" {
	vpc_id = aws_vpc.aws08-vpc.id
	cidr_block = var.public_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "aws08-public-subnet2c"
	}
}

# Private Subnet 2a
resource "aws_subnet" "aws08-private-subnet2a" {
	vpc_id = aws_vpc.aws08-vpc.id
	cidr_block = var.private_subnet[0]
	availability_zone = var.azs[0]

	tags = {
		Name = "aws08-private-subnet2a"
	}
}

# Private Subnet 2c
resource "aws_subnet" "aws08-private-subnet2c" {
	vpc_id = aws_vpc.aws08-vpc.id
	cidr_block = var.private_subnet[1]
	availability_zone = var.azs[1]

	tags = {
		Name = "aws08-private-subnet2c"
	}
}

