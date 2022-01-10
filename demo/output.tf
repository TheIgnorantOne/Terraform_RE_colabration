output "instance" {
  value = module.instance_sg.security_group_id
}

output "host_name" {
  value = module.ec2_instance.*.public_dns
}