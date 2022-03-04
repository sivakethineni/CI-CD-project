provider "aws" {
    region = "ap-south-1"
}

resource "aws_instance" "Docker-Server" {
    ami = "ami-0a74bfeb190bd404f" 
    instance_type = "t2.micro" 
    key_name = "ProvokeTrainings"
    security_groups = ["launch-wizard-19"] 
    tags = {
        Name = "Terraform Server by Provoke IT Trainings"
    }
}

output "ec2_public_ip" {
    value = aws_instance.myapp-server.public_ip
}
