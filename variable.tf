variable "aws_access_key" {
    type = string 
    descritpion = "AWS Access Key"
    sensitive = true 

}

variable "aws_secret_key" {
    type = string 
    descritpion = "AWS Secret Key"
    sensitive = true 

}

variable "aws_region"{
    type = string 
    descritpion = "AWS Region to use for resources"
    default = "use-east-1"
}


variable "enable_dns_hostnames" {
    type  = bool 
    descritpion = "Enable DNS hostname in VPC"
    default = true 
}

variable "vpc_cidr_block"{
    type = string
    descritpion = "Base CIDR Block for VPC"
    default = "10.0.0.0/24" 
}

variable "map_public_ip_on_launch" {
    type = bool 
    descritpion = "Map a ip address for subnet instances"
    default = true 

}

variable "instance_type" {
    type = string  
    descritpion = "Type for EC2 instances"
    default = "t2.micro" 

}


variable "company" {
    type = string  
    descritpion = "Company name for resource tagging"
    default = "Globalmantics"


}


variable "project" {
    type = string  
    descritpion = "project name for resource tagging"


}


variable "billing_code" {
    type = string  
    descritpion = "Company name for resource tagging"


}

