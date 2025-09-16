provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
  description = "test"
  default =   "ami-00ca32bbc84273381"
  
}

variable "instance_type" {
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "test" = "t3.micro"
    "prod" = "t2.xlarge"
  }
}

variable "stage" {
  type = map(string)
  default = {
    "dev" = "dev"
    "test" = "test"
    "prod" = "prod"
  }
}

module "dunder_ec2" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
    stage = lookup(var.stage, terraform.workspace, "misc")
    
}