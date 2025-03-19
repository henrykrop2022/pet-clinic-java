provider "aws" {
  region = "us-east-1"
}
provider "aws" {
  region = var.region
}
resource "aws_vpc" "vpc1" {
  cidr_block = "10.20.0.0/16"
  instance_tenancy = "default"
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.vpc1.id
}
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.20.1.0/24"
}
resource "aws_instance" "server1" {
  ami = "ami-04aa00acb1165b32a"
  instance_type = var.instance-type
  tags ={
    Name = var.env
  }
}
variable "env" {}
variable "region" {}
variable "instance-type" {}
