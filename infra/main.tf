# provider "aws" {
#   region = "us-east-1"
# }
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }
# resource "aws_vpc" "vpc1" {
#     cidr_block = "10.20.0.0/16"
#     instance_tenancy = "default"
# }
# resource "aws_internet_gateway" "igw1" {
#     vpc_id = aws_vpc.vpc1.id
# }
#  resource "aws_subnet" "subnet1" {
#     vpc_id     = aws_vpc.vpc1.id
#     cidr_block = "10.20.1.0/24"
#     availability_zone = "us-east-1a"
#     # map_public_ip_on_launch = true
#  }

# resource "aws_instance" "server1" {
#     ami = "ami-04aa00acb1165b32a"
#     instance_type = var.instance_type
#     subnet_id = aws_subnet.subnet1.id
#     key_name = "mykey"
#     tags = {
#         Name = "server1"
#     }
  
# }
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "env" {}

# Create VPC
resource "aws_vpc" "vpc1" {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "igw1"
  }
}

# Create Public Subnet
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet1"
  }
}

# Create Route Table
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "rt1"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

# Create Security Group
resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.vpc1.id

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg1"
  }
}

# Launch EC2 Instance
resource "aws_instance" "server1" {
  ami             = "ami-04aa00acb1165b32a"
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.subnet1.id
  key_name        = "mykey"
  security_groups = [aws_security_group.sg1.name]

  tags = {
    Name = "server1"
  }
}

 variable "env" {}
variable "region" {}
variable "instance_type" {}
  
