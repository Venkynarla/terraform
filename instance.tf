resource "aws_instance" "web" {
  ami           = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.instancesg.name}"] 
  user_data = <<-EOF
             #! /bin/bash
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "Welcome to first terraform website for testing" > /var/www/html/index.html
                EOF         


tags          = {
    Name        = "web"
    Location  = "Delhi"
  }
}

#instance security group for..

resource "aws_security_group" "instancesg" {
  name        = "instancesg"
  description = "Created the security group for ec2 instance"
  vpc_id      = "vpc-ced84ab4"

  ingress {
   
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }





  tags = {
    Name = "instancesg"
  }
}



