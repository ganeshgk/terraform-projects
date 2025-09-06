output "myoutput" {
value = {
    id        = aws_instance.day4.id
    public_ip = aws_instance.day4.public_ip
  }
}