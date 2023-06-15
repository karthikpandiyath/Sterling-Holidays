resource "aws_security_group" "allow_web" {
  vpc_id = var.vpc
name        = var.groupname
description = "Allows access to Web Port"
ingress {
from_port   = var.port_number_web
to_port     = var.port_number_web
protocol    = var.port_protocol_web
cidr_blocks = var.CIDR_webserver
}
}
data "template_file" "userdata" {
  template = file("${path.module}/boostrap.sh")
}
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name
  subnet_id = var.subnet
  security_groups = [aws_security_group.allow_web.id]
  associate_public_ip_address = true
  tags = {
    Name = "ssm1"
  }
  user_data = data.template_file.userdata.rendered
}
resource "aws_iam_instance_profile" "dev-resources-iam-profile" {
name = var.instancename
role = aws_iam_role.dev-resources-iam-role.name
}
resource "aws_iam_role" "dev-resources-iam-role" {
name        = var.rolename
description = "The role for the developer resources EC2"
assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": {
"Effect": "Allow",
"Principal": {"Service": "ec2.amazonaws.com"},
"Action": "sts:AssumeRole"
}
}
EOF
tags = {
stack = "test"
}
}
resource "aws_iam_role_policy_attachment" "dev-resources-ssm-policy" {
role       = aws_iam_role.dev-resources-iam-role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}