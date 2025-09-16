resource "aws_instance" "dunder" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "public-ec2",
        stage = var.stage
    }
}