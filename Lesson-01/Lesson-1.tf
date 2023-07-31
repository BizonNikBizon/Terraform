provider "aws" {
}
resource "aws_instance" "my_Amazon" {
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Bizon Nik"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "My_Amazon" {
  ami           = "ami-0b2ac948e23c57071"
  instance_type = "t2.micro"
  tags = {
    Name    = "My ubuntu Server"
    Owner   = "Bizon Nik"
    Project = "Terraform Lessons"
  }
}
