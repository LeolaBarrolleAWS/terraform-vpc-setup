terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  #access_key = "YOUR_ACCESS_KEY"
  #secret_key = "YOUR_SECRET_KEY"
}

variable "vpc_cidr_block" {
  
}

variable "web_subnet" {
  
}

variable "main_vpc_name" {
  
}

# resource "<provider>_<resource_type>" "local_name" {
#  argument1 = value1
#  argument = value 2
# ...
# }

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "Main VPC"
  }
}

# Create a subnet
resource "aws_subnet" "web" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.web_subnet
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "Web subnet"
  }
}

  resource "aws_internet_gateway" "my_web_igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      "Name" = "${var.main_vpc_name} IGW" 
    }
    
  }

resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_web_igw.id
  }
  tags = {
    "Name" = "my-default-rt"
  }
}


resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # Optionally: cidr_blocks = [var.my_public_ip] for tighter security
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Default Security Group"
  }
}

resource "aws_key_pair" "test_ssh_key" {
  key_name   = "test_ssh_key"
  public_key = file(var.ssh_public_key)

}

  




resource "aws_instance" "my_vm" {
  ami = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.web.id
  vpc_security_group_ids = [aws_default_security_group.default_sec_group.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.test_ssh_key.key_name
  user_data = ""
  tags = {
    "Name" = "My EC2 Instance - Amazon Linux 2"
  }
  
}
  

 

