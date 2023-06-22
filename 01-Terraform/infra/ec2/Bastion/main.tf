resource "aws_instance" "aws08_bastion" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = "aws08-key"
    # Security Group
    vpc_security_group_ids = [aws_security_group.aws08-ssh-sg.id]
    # Subnet
    subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet2a
    availability_zone = "ap-northeast-2a"
    # Allowing Public IP Association
    associate_public_ip_address = true

    tags = {
        Name = "aws08-bastion"
    }
}

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