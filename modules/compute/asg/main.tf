# AWS Key Pair associated with the public key found in the ~/.ssh/id_rsa.pub file. 
# This key pair can then be used to connect to the EC2s via ssh.
resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

# AWS launch configuration for the Auto Scaling Group (ASG)
resource "aws_launch_configuration" "asg_config" {
    name_prefix   = "asg-config-"
    image_id      = var.ami_id
    instance_type = "t2.micro"
    key_name         = aws_key_pair.deployer.key_name
    security_groups = [var.security_group]
    associate_public_ip_address = false
    
    # installing nginx on the EC2 instances
    user_data = <<-EOF
                #!/bin/bash
                apt-get update -y && apt-get install -y nginx
                EOF
    
    lifecycle {
      create_before_destroy = true
    }
}

# first availability zone is assigned to asg_1
resource "aws_autoscaling_group" "asg_1" {
  name                      = "asg-1"
  launch_configuration      = aws_launch_configuration.asg_config.name
  min_size                  = 1
  max_size                  = 3
  vpc_zone_identifier       =  [var.subnet_group_private_ids[0]]
  target_group_arns         = [var.target_group_arn]

  lifecycle {
    create_before_destroy = true
  }
}

# second availability zone is assigned to asg_2
resource "aws_autoscaling_group" "asg_2" {
  name                      = "asg-2"
  launch_configuration      = aws_launch_configuration.asg_config.name
  min_size                  = 1
  max_size                  = 3
  vpc_zone_identifier       = [var.subnet_group_private_ids[1]]
  target_group_arns         = [var.target_group_arn]

  lifecycle {
    create_before_destroy = true
  }
}




