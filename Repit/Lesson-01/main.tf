provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "My_Linux" {
  count         = 3
  ami           = "ami-0c4c4bd6cf0c5fe52"
  instance_type = "t2.micro"
  tags = {
    Name = "Linux"
  }
}


resource "aws_instance" "My_Ubuntu" {
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"
  tags = {
    Name = "Ubuntu"
  }
}
