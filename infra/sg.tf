resource "aws_security_group" "private" {
  name        = "private_ecs_sg"
  vpc_id      = module.vpc.vpc_id
 }
 
 
resource "aws_vpc_security_group_ingress_rule" "input_ecs" {
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.private.id
  cidr_ipv4         = ["0.0.0.0/0"]
  ip_protocol       = "-1"
}

resource "aws_vpc_security_gresourceresourceroup_ingress_rule" "output_ecs" {
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.private.id
  cidr_ipv4         = ["0.0.0.0/0"]
  ip_protocol       = "-1"
}
