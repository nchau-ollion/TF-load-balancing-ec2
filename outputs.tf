/*
output "vpc_id" {
  value         = data.aws_vpcs.nchau-vpc.ids[0]  
  description   = "List of Nicole's VPCs"
}

output "aws_s3_bucket" {
  description   = "bucket_name"
  value         = aws_s3_bucket.nc-bucket.id
}
change to LB ip
output "website_url" {
  value = "http:\\${aws_instance.web_server.public_ip}"
}*/