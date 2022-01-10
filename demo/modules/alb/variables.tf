variable "create_lb" {
  type    = bool
  default = false
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
  type        = bool
  default     = false
}

variable "internal" {
  description = "Boolean determining if the load balancer is internal or externally facing."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network."
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "security_groups" {
  description = "The security groups to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
  default     = []
}

variable "target_groups" {
  description = "A list of maps containing key/value pairs that define the target groups to be created."
  type        = any
  default     = []
}

variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed."
  type        = string
  default     = null
}

variable "target_group_arn" {
  description = "VPC id where the load balancer and other resources will be deployed."
  type        = string
  default     = null
}

variable "taget_ids" {
  description = "Target ids."
  type        = list(string)
  default     = null
}

variable "target_service_port" {
  description = "VPC id where the load balancer and other resources will be deployed."
  type        = number
  default     = 80
}

variable "idle_timeout" {
  description = "Client Session idle timeout"
  type        = number
  default     = 60
}

variable "name" {
  description = "Load Balancer Name"
  type        = string
}

variable "name_prefix" {
  description = "Load Balancer name prefix"
  type        = string
}