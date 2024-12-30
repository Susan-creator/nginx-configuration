variable "ami" {
    description = "the ami id to use for the instances"
    default = "ami-0e2c8caa4b6378d8c"
  
}

variable "instance_type" {
    description = "the type of instance to launch"
    default = "t2.micro"
  
}