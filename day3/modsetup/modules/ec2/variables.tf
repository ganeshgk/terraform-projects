variable "ami_id_value" {
  description = "The AMI ID to use for the instance"
  type        = string
  
}

variable "instance_type_value" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id_value" {
  description = "The Subnet ID to launch the instance in"
  type        = string
  
}