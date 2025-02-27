resource "aws_instance" "app_instance" {
  instance_type = "t2.micro"

  tags = {
    Name = var.ec2_name
  } 
}