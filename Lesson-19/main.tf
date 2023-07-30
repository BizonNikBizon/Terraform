provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "USA"
}

provider "aws" {
  region = "sa-east-1"
  alias  = "SA"
}

#======================================================================================
data "aws_ami" "SA_latest_ubuntu" {
  provider    = "aws.SA"
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_ami" "USA_latest_ubuntu" {
  provider    = "aws.USA"
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
data "aws_ami" "default_latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_default_server" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.default_latest_ubuntu.id
  tags = {
    Name = "Frankfurt Server"
  }
}

resource "aws_instance" "my_USA_server" {
  provider      = aws.USA
  instance_type = "t2.micro"
  ami           = data.aws_ami.USA_latest_ubuntu.id
  tags = {
    Name = "USA Server"
  }
}

resource "aws_instance" "my_SA_server" {
  provider      = aws.SA
  instance_type = "t2.micro"
  ami           = data.aws_ami.SA_latest_ubuntu.id
  tags = {
    Name = "San Paulu Server"
  }
}

