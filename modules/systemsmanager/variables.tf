variable "vpc" {

}
variable "groupname" {
  default="web"
}
variable "ami" {

}
variable "subnet" {
  
}
variable "instancename" {
  
}
variable "rolename" {
  default="dev-ssm-role"
}
variable "port_number_web" {
  default = "22"
}
variable "port_protocol_web" {
  default = "tcp"
}

variable "CIDR_webserver" {
    default = ["0.0.0.0/0"]
  
}