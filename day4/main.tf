resource "aws_instance" "day4" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "day4-instance"
  }
  
}

resource "aws_s3_bucket" "day4bucket" {
   bucket = "subu-learning-t4m"

  tags = {
    Name        = "day4bucket"
    env = "learning"
  }
  
}

resource "aws_dynamodb_table" "tflockdb" {
  name             = "terraform-lock-table"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }


}