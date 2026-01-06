# Configure the AWS provider
provider "aws" {
  alias = "east"
  region = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
}
