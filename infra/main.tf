provider "aws" {
  region = "us-east-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
resource "aws_vpc" "vpc1" {
    cidr_block = "10.20.0.0/16"
    instance_tenancy = "default"
}
resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.vpc1.id
}
 resource "aws_subnet" "subnet1" {
    vpc_id     = aws_vpc.vpc1.id
    cidr_block = "10.20.1.0/24"
    availability_zone = "us-east-1a"
    # map_public_ip_on_launch = true
 }

resource "aws_instance" "server1" {
    ami = "ami-04aa00acb1165b32a"
    instance_type = var.instance_type
    subnet_id = aws_subnet.subnet1.id
    key_name = "mykey"
    tags = {
        Name = "server1"
    }
  
}
 variable "env" {}
variable "region" {}
variable "instance_type" {}
  
