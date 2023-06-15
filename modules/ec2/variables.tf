variable "web_securitygroup" {
  default = "web_securitygroup"
}
variable "web_1_ami" {
}
variable "vpc_id" {
}

variable "subnet_id" {
    
}
variable "Volumesize_web_1" {
  default = "50"
}
variable "instance_count" {
  
}
variable "instance_type_web1" {
  
}
variable "devicename_web1" {
  
}
variable "Volumetype_web1" {
  
}
variable "port_number_web" {
  default = "22"
}
variable "port_number_web" {
  default = "tcp"
}

variable "CIDR_webserver" {
    default = ["0.0.0.0/0"]
  
}

variable "web1_name" {
  type = list(string)
}