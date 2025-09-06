variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-00ca32bbc84273381" # Example AMI ID, change as needed
  
}
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}