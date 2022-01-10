variable "instance_ami" {
  description = "Instance AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "Instance private Key"
  type        = string
}

variable "security_group_ids" {
  description = "List Of Security Group ids"
  type        = list(string)
}

variable "tags" {
  description = "Tags"
  type        = map(any)
}

variable "instance_count" {
  description = "Number Of Instances"
  type        = number
  default     = 1
}

variable "public_ip" {
  description = "Associate Public IP"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}