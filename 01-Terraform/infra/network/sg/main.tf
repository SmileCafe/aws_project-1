#Default Security Group
#resource "aws_default_security_group" "aws00_default_sg" {
#    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
#
#    ingress {
#        protocol = "tcp"
#        from_port = 0
#        to_port = 65535
#        cidr_blocks = [data.terraform_remote_state.aws00_vpc.outputs.vpc_cidr]
#    }
#
#    egress {
#        protocol = "-1"
#        from_port = 0
#        to_port = 0
#        cidr_blocks = ["0.0.0.0/0"]
#    }
#
#    tags = {
#        Name = "aws08-default-sg"
#        Description = "Default Security Group"
#    }
#}

# Default SSH Group
 resource "aws_security_group" "aws08-ssh-sg" {
    name = "aws08-ssh-sg"
    description = "Security Group for SSH Server"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
 
     ingress {
        description ="For SSH Port"
         protocol = "tcp"
         from_port = 22
         to_port = 22
         cidr_blocks = ["0.0.0.0/0"]
     }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "aws08-ssh-sg"
    }
}

# WEB Security Group
 resource "aws_security_group" "aws08-web-sg" {
    name = "aws08-web-sg"
    description = "Security Group for WEB Server"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
 
     ingress {
        description ="For Web Port"
         protocol = "tcp"
         from_port = 80
         to_port = 80
         cidr_blocks = ["0.0.0.0/0"]
     }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "aws08-web-sg"
    }
}