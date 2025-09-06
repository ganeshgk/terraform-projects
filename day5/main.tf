resource "aws_key_pair" "ganesh-tf-demo" {
  id = "ganesh-tf-demo"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "custom_vpc"
  }
  
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.custom_vpc.id
  
}

resource "aws_route_table" "myRT" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "custom_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.myRT.id
}

resource "aws_security_group" "web" {
  name = "web"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    description = "http to instance"
    from_port = 80
    to_port = 80
    cidr_blocks = "0.0.0.0/0"
  }
  ingress {
    description = "ssh to instance"
    from_port = 22
    to_port = 22
    cidr_blocks = "0.0.0.0/0"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "my-tf-demo" {
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet.id
    ami = "ami-0360c520857e3138f"
    vpc_security_group_ids = aws_security_group.web.id

  connection {
    user = "ubuntu"
    type = "ssh"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip

  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
    
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",
      "sudo apt install python3-pip -y",
      "cd /home/ubuntu",
      "pip3 install flask",
      "nohup python3 /home/ubuntu/app.py &"
    ]
    
  }

}