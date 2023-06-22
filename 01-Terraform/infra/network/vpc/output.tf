output "vpc_id" {
    value = aws_vpc.aws08-vpc.id
}

output "public_subnet2a" {
    value = aws_subnet.aws08-public-subnet2a.id
}

output "public_subnet2c" {
    value = aws_subnet.aws08-public-subnet2c.id
}

output "private_subnet2a" {
    value = aws_subnet.aws08-private-subnet2a.id
}

output "private_subnet2c" {
    value = aws_subnet.aws08-private-subnet2c.id
}


#output "public_subnet_arns" {
#    value = aws_vpc.aws08-vpc.public_subnet_arns
#}