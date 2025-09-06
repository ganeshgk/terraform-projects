output "public-ip" {
 value = aws_instance.own-ec2.public_dns
}