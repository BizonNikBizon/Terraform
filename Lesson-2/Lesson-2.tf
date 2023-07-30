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

resource "aws_instance" "my_webserver" {
    ami = "ami-0b2ac948e23c57071"    # Amazon Linux AMI
  instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.my_WebServer.id]
user_data           = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

tags           = {
Name = "Web Server Buil by Terraform"
Owner = "Bizon Nik"
}
}
resource "aws_security_group" "my_WebServer" {
  name        = "Web_Server Security group"
  description = "Web_Server Securitygroup"
}
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
