#-------------------------------------------------------------------------------
# My terraform
#
# Variables
#
# Made by Bizon Nik
#
#-------------------------------------------------------------------------------
provider "aws" {
  region = var.region
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server.id
  tags     = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server IP" }) #merge - это соединение тагов в данном случае тех что в variables + 
  #доп таг к этому ресурсу не относяшийся к variables 
  #{ Name = "${var.common_tags["Environment"]} Server IP" }) ---- тут добавили к сервер ip доп variables (development)

  /*
  tags = {
    Name    = "Server IP"
    Owner   = "Bizon Nik"
    Project = "Megatron"
      }
*/
}

resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  tags                   = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server Build by Terraform" })
}

resource "aws_security_group" "my_server" {
  name = "My Security Group"
  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Server SecurityGroup" })
}
