#-------------------------------------------------------------------
# My Terraform
#
# Build WebServer during Bootsrap
#
#Made Bizon Nik
#-------------------------------------------------------------------
provider "aws" {
 region = "eu-central-1" 
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_instance" "my_webserver" {
    ami = "ami-0b2ac948e23c57071"    # Amazon Linux AMI
  instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.my_WebServer.id]
user_data           = templatefile("user_data.sh.tpl", {
  f_name = "Nik",
  l_name = "Bizon",
  names = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
})

tags           = {
Name = "Web Server Buil by Terraform"
Owner = "Bizon Nik!"
}
}
resource "aws_security_group" "my_WebServer" {
  name        = "Web_Server Security group"
  description = "Web_Server Securitygroup"
vpc_id = aws_default_vpc.default.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }

ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

 tags = {
Name = "Web Server Buil by Terraform"
Owner = "Bizon Nik"
}
}