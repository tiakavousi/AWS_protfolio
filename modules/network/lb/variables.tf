variable "vpc_security_group_name" {
  type        = list(string)
}

variable "subnet_group_public_ids" {
  type        = list(string)
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}