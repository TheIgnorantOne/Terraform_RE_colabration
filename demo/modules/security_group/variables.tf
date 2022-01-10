variable "ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  type = map(any)
  default = {
    Name = "security-group"
  }
}

variable "vpc_id" {
  type = string
}

variable "security_group_name" {
}

variable "security_group_description" {
  default = "security-group"
}