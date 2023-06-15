resource "aws_security_group" "web_securitygroup" {
  name   = var.web_securitygroup
  vpc_id = var.vpc_id
  // To Allow SSH Transport
  ingress {
    from_port   = var.port_number_web
    protocol    = var.security_ingress_protocol_web
    to_port     = var.port_number_web
    cidr_blocks = var.CIDR_webserver

}
}
resource "aws_instance" "web_1" {
  count                     = var.instance_count
  ami                         = var.web_1_ami
  instance_type               = var.instance_type_web1
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.web_securitygroup.id]
  associate_public_ip_address = true
  user_data = data.template_file.userdata.rendered
  ebs_block_device {
    device_name = var.devicename_web1
    volume_size = var.Volumesize_web_1
    volume_type = var.Volumetype_web1
  }
  tags = {
    Name = var.web1_name[count.index]
  }
}