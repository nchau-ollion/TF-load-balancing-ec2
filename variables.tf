variable  "aws_region" {
    type    = string
    default = "us-west-1"
}
variable "vpc_azs" {
  type    = list(string)
  default = [ "us-west-1a", "us-west-1c" ]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "resource_tags" {
  description   = "Tags to set for all resources"
  type          = map(string)
  default = {
    Name        = "nchau"
    Project     = "Terraform", 
    # autopark    = "M-F 9-5"   future development
  }
}
/*
variable "instance_count" {
  type        = string
  description = "The number of instances to create"
  default     = "1"
}
*/
variable "instance_type" {
  type        = string
  description = "The instance size type"
  default     = "t2.micro"
}

variable "server_port" {
  type        = string
  description = "The port the server will use for HTTP requests in user data script"
  default     = "80"
}