variable "ami_id" {
  description = "Image ID for the autoscaling groups"
  type = string
}

variable "target_group_arn" {
  description = "ARN of the target group for the autoscaling groups"
  type        = string
}

variable "subnet_group_private_ids" {
  type = list(string)
}

variable "security_group" {
  type        = string
}