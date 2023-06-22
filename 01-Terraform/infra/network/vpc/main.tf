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

# Internet Gateway
resource "aws_internet_gateway" "aws08-igw" {
	vpc_id = aws_vpc.aws08-vpc.id

	tags = {
		Name = "aws08-Internet-gateway"
	}
}

# EIP for NAT Gateway
resource "aws_eip" "aws08-eip" {
	vpc = true
	depends_on = [ "aws_internet_gateway.aws08-igw" ]
	lifecycle {
		create_before_destroy = true
	}
}

# NAT Gateway
resource "aws_nat_gateway" "aws08-nat" {
	allocation_id = aws_eip.aws08-eip.id
	# Subnet Location for NAT
	subnet_id = aws_subnet.aws08-public-subnet2a.id
	depends_on = [ "aws_internet_gateway.aws08-igw" ]
}

# 
resource "aws_default_route_table" "aws08-public-rt" {
	default_route_table_id = aws_vpc.aws08-vpc.default_route_table_id

		route {
			cidr_block = "0.0.0.0/0"
			gateway_id = aws_internet_gateway.aws08-igw.id
		}

	tags = {
		Name = "aws08 Public Route Table"
	}
}

resource "aws_route_table_association" "aws08-public-rta-2a" {
	subnet_id = aws_subnet.aws08-public-subnet2a.id
	route_table_id = aws_default_route_table.aws08-public-rt.id
}

resource "aws_route_table_association" "aws08-public-rta-2c" {
	subnet_id = aws_subnet.aws08-public-subnet2c.id
	route_table_id = aws_default_route_table.aws08-public-rt.id
}


# Private
resource "aws_route_table" "aws08-private-rt" {
	vpc_id = aws_vpc.aws08-vpc.id
	tags = {
		Name = "aws08 Private Route Table"
	}
}

resource "aws_route_table_association" "aws08-private-rta-2a" {
	subnet_id = aws_subnet.aws08-private-subnet2a.id
	route_table_id = aws_route_table.aws08-private-rt.id
}

resource "aws_route_table_association" "aws08-private-rta-2c" {
	subnet_id = aws_subnet.aws08-private-subnet2c.id
	route_table_id = aws_route_table.aws08-private-rt.id
}

resource "aws_route" "aws08-private-rt-table" {
	route_table_id = aws_route_table.aws08-private-rt.id
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.aws08-nat.id
}
