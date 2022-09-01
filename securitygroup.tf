resource "aws_security_group" "nidio-acesso-ssh-private" {
  description = "nidio sg acesso ssh"
  vpc_id = aws_vpc.nidio_vpc.id
 
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "nidio_sg_ssh"
  }
}

resource "aws_security_group" "nidio-acesso-web" {
  name = "nidio-acesso-web"
  description = "nidio sg acesso web"
  vpc_id = aws_vpc.nidio_vpc.id
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "nidio_sg_web"
  }
}


resource "aws_security_group" "nidio-acesso-ssh-mngt" {
  name = "nidio-acesso-ssh-mngt"
  description = "nidio sg acesso ssh-mngt"
  vpc_id = aws_vpc.nidio_vpc.id
 
  ingress {
    description      = "SSH-mngt"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "nidio_sg_ssh-mngt"
  }
}