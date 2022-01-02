#############
#provider
#############


provider "aws" {
    access_key =  var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region
}





######################
#DATA
####################


data "aws_ssm_parameter" "ami" {
    name =  "/aws/service/ami-amazon-linux-latest/amzn2-ami-hmv-x86_64-gp2"
}


########
# RESOURCES
############



 
#NETWORKING 

resources "aws_Vpc" "VPC" {
    cirdr_block = "10.0.0/16"
    enable_dns_hostnames = "true"
    tags = local.common_tags
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_Vpc.Vpc.id
    tags = local.common_tags
}

resource "aws_subnet" "subnet1"{
 cirdr_blocks            = var.vpc_cidr_block
 vpc_id                 = aws_Vpc.VPC.id
 tags = local.common_tags
}


#routing#

resource "aws_route_table" {

    vcp_id = aws_vpc.vpc.id 
    route {
        cirdr_blocks = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id 
    }
}

resource "aws_route_table_association" "rta_subnet1"{
    subnet_id    = aws_subnet.subnet1.id 
    route_table_id = aws_route_table.rtb.id 
}

# security Groups# 

resource "aws_security_group" "nginx-sg" {
    name = "nginx_sg"
    vcp_id = aws_vpc.vpc.id
    tags = local.common_tags
}

#http access from anywhere # 

ingress { 
    from_port = 80 
    to_port  = 80 
    protocol = "tcp"
    cirdr_blocks = ["0.0.0.0/0"]
}


# outbound internet access 
egress{
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cirdr_blocks = ["0.0.0.0/0"]
}


# Instances # 

resource "aws_instance" "nginx1" {
    ami                 = nonsensitve(data.aws_ssm_parameter)
    Instance_sype       = var.instance_type
    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.nginx_sg.id]
tags = local.common_tags


user_data = <<EOF
#! /bin/bash 

sudo amazon-linux-extras install -y nginx1
sudo service nginx start 
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title> Taci team server</title></head></html>'

EOF

}