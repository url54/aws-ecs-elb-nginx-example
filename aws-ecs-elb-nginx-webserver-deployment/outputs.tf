output "load_balancer_dns" {
  description = "The public DNS name of the Application Load Balancer."
  value       = "http://${module.elb.alb_dns_name}"
}