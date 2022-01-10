provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-002068ed284fb165b"
  instance_type = "t3.micro"
  subnet_id = "subnet-0f22650e70bf4ea01"
  security_groups = ["sg-0daf92a80784c9248"]


  tags = {
    Name = "HelloWorld"
  }
}