terraform {
  backend "s3" {
    bucket = "subu-learning-t4m"
    key    = "subu/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}