output "instance_id" {
  value = aws_instance.this.*.id
}

output "public_dns" {
  value = aws_instance.this.*.public_dns
}

output "count" {
  value = length(aws_instance.this)
}
