provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "task_tracker" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "task-tracker-api"
  }

  vpc_security_group_ids = [aws_security_group.allow_web.id]

  user_data = file("${path.module}/init.sh")
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow HTTP and SSH"

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  ingress {
    description      = "Allow Flask API (port 3007)"
    from_port        = 3007
    to_port          = 3007
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
}