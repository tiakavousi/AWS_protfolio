variable "aws_region" {
  type        = string
  description = "AWS region for provisioning"
}

variable "aws_profile" {
  default     = "default"
  description = "AWS profile using for connect to AWS"
}

variable "default_tags" {
  default = {
    Provisioner = "Terraform"
    Environment = "Production"
    Project     = "IU university course - Cloud Programming"
  }
  type        = map(string)
  description = "Default tag for all resources"
}

variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
  type        = string
  default     = null
}

variable "ami_id" {
  description = "ID of Amazon Machine Images (AMI) used for auto-scaling group"
  type        = string
  default     = "ami-053b0d53c279acc90"
}




