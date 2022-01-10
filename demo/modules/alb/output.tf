output "lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = concat(aws_lb.this.*.id, [""])[0]
}
output "lb_arn" {
  value = aws_lb.this.*.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = concat(aws_lb.this.*.dns_name, [""])[0]
}

output "target_group_arns" {
  description = "ARNs of the target groups."
  value       = aws_lb_target_group.main.*.arn
}

output "target_group_names" {
  description = "Name of the target group."
  value       = aws_lb_target_group.main.*.name
}