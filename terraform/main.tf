provider "aws" {
    region = "ap-south-1"
}

data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

output "ami_id" {
  value = data.aws_ami.amazon-linux-image.id
}

resource "aws_instance" "Docker-Server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = "t2.micro" 
    key_name = "Jenkins-new-key"
    security_groups = ["All-Traffic-SG"]
    user_data = file("entry-script.sh")
    tags = {
        Name = "Docker Server by Terraform"
    }
}


output "ec2_public_ip" {
    value = aws_instance.Docker-Server.public_ip
}
