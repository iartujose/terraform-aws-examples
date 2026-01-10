# Configure the AWS provider
provider "aws" {
  alias = "east"
  region = "us-east-1"
}

# Create a Security Group for an EC2 instance
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port	  = 8080
    to_port	    = 8080
    protocol	  = "tcp"
    cidr_blocks	= ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami                     = "ami-068c0051b15cdb816"
  instance_type           = "t3.micro"
  vpc_security_group_ids  = ["${aws_security_group.instance.id}"]
  
  user_data = <<-EOF
	      #!/bin/bash
	      echo "Hello, World" > index.html
	      nohup busybox httpd -f -p 8080 &
	      EOF
}

# Output variable: Public IP address
output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
