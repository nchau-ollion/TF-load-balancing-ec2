output "website_url" {
  description = "The DNS name of the load balancer"
  value = "http:\\${aws_lb.app_lb.dns_name}"
}