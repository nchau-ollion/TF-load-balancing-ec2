variable  "aws_region" {
    description = "The region for all the resources"
    type    = string
    default = "us-west-1"
}
variable "vpc_azs" {
  description = "The AZs for all the resources"
  type    = list(string)
  default = [ "us-west-1a", "us-west-1c" ]
}

variable "private_subnets" {
  description = "The CIDRs for the private subnets"
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "The CIDRs for the public subnets"
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "resource_tags" {
  description   = "The tags for all the resources"
  type          = map(string)
  default = {
    Name        = "nchau"
    Project     = "Terraform", 
    # Autopark    = "M-F 9-5"   # future development
  }
}

variable "instance_type" {
  type        = string
  description = "The instance size type"
  default     = "t2.micro"
}