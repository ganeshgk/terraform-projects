resource "aws_instance" "own-ec2" {
    subnet_id = var.subnet_id_value
    instance_type = var.instance_type_value
    ami = var.ami_id_value 
}