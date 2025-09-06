provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "ganu" {
    ami           = "ami-00ca32bbc84273381"  # Specify an appropriate AMI ID
    instance_type = "t3.micro"
    tags = {
        Name = "public-ec2",
        stage = "learning"
    }
}