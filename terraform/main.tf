provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "Docker-Server" {
    ami = "ami-08ee6644906ff4d6c" 
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
