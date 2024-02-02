terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.29.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.1"
  
  name    = "nchau-vpc"
  cidr    = "10.0.0.0/16"

  azs             = var.vpc_azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = var.resource_tags
}

resource "aws_security_group" "for_lb" {
  name        = "sg_for_lb"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags          = var.resource_tags
}

data "aws_ami" "latest_linux_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name    = "name"
    values  = ["al2023-ami*-x86_64"]
  }
}

resource "aws_lb" "app_lb" {
  name                = "app-lb"
  internal            = false
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.for_lb.id]
  subnets             = module.vpc.public_subnets
}

resource "aws_lb_target_group" "target_group" {
  name = "web-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = module.vpc.vpc_id
  health_check {
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    matcher = "200-299"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

#register instance to target group
resource "aws_lb_target_group_attachment" "web_server_attach" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.web_server.id
  port             = 80
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.latest_linux_ami.id
  #count         = var.instance_count
  instance_type = var.instance_type
  user_data     = templatefile("${path.module}/cloud-config.yml", {})
  depends_on    = [aws_security_group.for_lb]
  subnet_id     = module.vpc.private_subnets[0]  #eventually for each
  vpc_security_group_ids = [aws_security_group.for_lb.id]
  associate_public_ip_address = true
  tags          = var.resource_tags
}