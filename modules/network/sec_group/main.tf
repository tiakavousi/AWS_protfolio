resource "aws_security_group" "asg-sg" {
  name   = "asg-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # allows incoming traffic from any IPv4 address
  security_group_id = aws_security_group.asg-sg.id
}

resource "aws_security_group_rule" "ingress_443" {
  type              = "ingress" # inbound traffic 
  from_port         = 443 
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # allows incoming traffic from any IPv4 address
  security_group_id = aws_security_group.asg-sg.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress" # outbound traffic 
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # any protocol
  cidr_blocks       = ["0.0.0.0/0"] # allows incoming traffic from any IPv4 address
  security_group_id = aws_security_group.asg-sg.id
}
