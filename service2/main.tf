provider "aws" {
  access_key = "AKIAV2DPEGDQDQY73MPQ"
  secret_key = "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"
  region = "eu-central-1"
}

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "DemoVPC"
  }
}

resource "aws_subnet" "demo_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "DemoSubnet"
  }
}

resource "aws_security_group" "demo_sg" {
  vpc_id = aws_vpc.demo_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DemoSG"
  }
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-0b9094fa2b07038b8" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.demo_subnet.id
  tags = {
    Name = "DemoInstance"
  }
}
