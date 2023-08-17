output "loadbalancer_dns" {
  description = "The DNS name of the load balancer."
  value       = module.lb.lb_dns_name
}
