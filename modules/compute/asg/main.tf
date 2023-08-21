# AWS Key Pair associated with the public key found in the ~/.ssh/id_rsa.pub file. 
# This key pair can be used to connect to the EC2s via ssh. 
# for ssh connection aws_security_group_rule" "ingress_22 must be added first.
resource "aws_key_pair" "deployer" {
    key_name   = "deployer-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

# AWS launch configuration for the Auto Scaling Group (ASG) create the EC2 instances with below config:
resource "aws_launch_configuration" "asg_config" {
    name_prefix   = "asg-config-"     # Creates a unique name beginning with the specified prefix
    image_id      = var.ami_id        # The EC2 image ID to launch
    instance_type = "t2.micro"        # The size of instance to launch
    key_name         = aws_key_pair.deployer.key_name
    security_groups = [var.security_group]  # A list of associated security group IDS.
    associate_public_ip_address = false
    
    # userdata script executes as part of the instance launch process by the EC2 instances
    user_data = templatefile("${path.module}/userdata.tpl", {
    cloudfront_dns = var.cloudfront_dns
    })
    
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




