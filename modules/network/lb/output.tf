output "aws_lb_target_group" {
  value = aws_lb_target_group.main.id
}


output "target_group_arn" {
  description = "ARN of the target group associated with the autoscaling groups."
  value      = aws_lb_target_group.main.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.lb.dns_name
}
