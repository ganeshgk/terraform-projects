provider "aws" {
  region = "us-east-1"
  
}

module "my-ec2-module" {
  source = "./modules/ec2"
  ami_id_value = "ami-00ca32bbc84273381"
  instance_type_value = "t3.micro"
  subnet_id_value = "subnet-034af6006be000290"
  
}
 output "public-ip" {
   value = module.my-ec2-module.public-ip
 }