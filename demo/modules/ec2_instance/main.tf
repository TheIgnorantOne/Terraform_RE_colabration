resource "aws_instance" "this" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = var.instance_keypair
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.public_ip
  subnet_id                   = var.subnet_id

  tags = var.tags
}
