data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "aws00-terraform-state"
        key = "infra/network/vpc/terraform.tfstate"
        region = "ap-northeast-2"
    }
}