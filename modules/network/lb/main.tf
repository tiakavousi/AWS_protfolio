resource "aws_lb" "lb" {
  name               = "main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_group_public_ids  # A list of subnet IDs to attach to the LB

  enable_deletion_protection = false # default is false, this is mentioned for explicity

  tags = {
    "Name" = "main_loadbalancer"
  }
}


resource "aws_lb_target_group" "main" {  #target_type by default is instance
  name     = "main-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id 

  health_check {
    enabled             = true
    interval            = 30        # Approximate amount of time, in seconds, between health checks of an individual target
    path                = "/"       # Destination for the health check request
    port                = "80"      # The port the load balancer uses when performing health checks
    protocol            = "HTTP"    # Protocol the load balancer uses when performing health checks
    timeout             = 6         # Amount of time, in seconds, during which no response from a target means a failed health check
    healthy_threshold   = 2         # Number of consecutive health check successes required before considering a target healthy
    unhealthy_threshold = 2         # Number of consecutive health check failures required before considering a target unhealthy
    matcher             = "200-299" # Response codes to use when checking for a healthy responses from a target
  }
}

resource "aws_lb_listener" "main" { 
  load_balancer_arn = aws_lb.lb.arn # ARN (Amazon Resource Name) of lb
  port              = "80"          # Port on which the load balancer is listening
  protocol          = "HTTP"        # Protocol for connections from clients to the load balancer.

  default_action {
    type             = "forward"    # forward incoming requests to a target group.
    target_group_arn = aws_lb_target_group.main.arn  # ARN of the Target Group to which to route traffic
  }
}
