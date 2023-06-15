module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.cidr_block
    availability_zones = var.availability_zones
    public_cidr_block = var.public_sub_cidr
    public_subnet_name = var.pub_sub_name
    igw_name = var.igw_name
    RTname = var.route_table_name
}



module "systemmanager" {
    source = "./modules/systemsmanager"
    vpc = module.vpc.vpc_id
    ami = var.ami_id_ssm
    subnet = module.vpc.subnet_id
    instancename = var.instancename
  
}

module "ec2" {
    source = "./modules/ec2"
    web_1_ami = var.ami
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
    instance_count = var.instance_count
    web1_name = var.web_instance_name
    
}

module "cloud_watch" {
    source = "./modules/cloudwatch"
    dashboard_name = var.dashboardname
    alarm_name = var.alarm_name
  
}

module "cloudtrail" {
    source = "./modules/cloudtrail"
    cloud_trail_name = var.cloud_trail_name
    bucket_name = var.cloudtrail_bucket
  
}

module "config" {
    source = "./modules/Config"
    account_id = var.account_id
    region = var.region
  
}