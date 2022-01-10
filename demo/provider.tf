provider "aws" {
  profile = "default"
  region  = var.aws_region
}

terraform {
  required_version = ">= 1.0.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
