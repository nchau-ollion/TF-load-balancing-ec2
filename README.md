# Deploy Load Balanced EC2 instance and Infrastructure
This repository contains Terraform configurations for deploying a VPC, security groups, an application load balancer, target groups, and EC2 instances on AWS.

## Deployment Steps
1. **Initialize Terraform**:
Run terraform init in the directory containing the Terraform configuration files to initialize the Terraform environment.

2. **Plan the Deployment**:
Run terraform plan to see the changes that Terraform will make to your AWS infrastructure.

3. **Apply the Configuration**:
Run terraform apply to apply the configuration and create the infrastructure. Confirm the action when prompted.

#### Readme
This readme was written with terraform docs markdown ([here](https://github.com/terraform-docs/terraform-docs)) and can be automatically updated for Windows with update-readme.ps1 ([here](https://github.com/nchau-ollion/TF-load-balancing-ec2/blob/feature/auto-scaling/update-readme.ps1)) and for Mac with update-readme.sh ([here](https://github.com/2ndWatch/TF-AWS-IAM-Cross-Account-Role/blob/main/update-readme.sh)).


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.5.1 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.web_server_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.web_server_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.app_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.for_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.latest_linux_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The region for all the resources | `string` | `"us-west-1"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance size type | `string` | `"t2.micro"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The CIDRs for the private subnets | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The CIDRs for the public subnets | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24"<br>]</pre> | no |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | The tags for all the resources | `map(string)` | <pre>{<br>  "Name": "nchau",<br>  "Project": "Terraform"<br>}</pre> | no |
| <a name="input_vpc_azs"></a> [vpc\_azs](#input\_vpc\_azs) | The AZs for all the resources | `list(string)` | <pre>[<br>  "us-west-1a",<br>  "us-west-1c"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_website_url"></a> [website\_url](#output\_website\_url) | The DNS name of the load balancer |
<!-- END_TF_DOCS -->



