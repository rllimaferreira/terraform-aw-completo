resource "aws_instance" "front_nidio-ec2" {
    count = 2
    ami = "ami-085284d24fe829cd0"
    instance_type = "t2.micro"
    tags = {
      Name = "front_nidio-ec2-${count.index}"
    }
    key_name = "nidio-terraform-aws"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.nidio-acesso-ssh-private.id}","${aws_security_group.nidio-acesso-web.id}" ]
    subnet_id = aws_subnet.nidio_public_subnet.id
    user_data = <<-EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo git clone https://github.com/nidiodolfini/aula21
      sudo chmod 777 -R aula21/
      sudo cp -rf aula21/* /var/www/html/
    EOF

}

resource "aws_instance" "back_nidio-ec2" {
    tags = {
      Name = "back_nidio-ec2-${count.index}"
    }
    count = 1
    ami = "ami-085284d24fe829cd0"
    instance_type = "t2.micro"
    key_name = "nidio-terraform-aws"
    subnet_id = aws_subnet.nidio_private_subnet.id
    vpc_security_group_ids = ["${aws_security_group.nidio-acesso-ssh-private.id}","${aws_security_group.nidio-acesso-web.id}" ]
    
}

resource "aws_instance" "mngt_nidio-ec2" {
    count = 1
    ami = "ami-085284d24fe829cd0"
    instance_type = "t2.micro"
    tags = {
      Name = "mngt_nidio-ec2-${count.index}"
    }
    key_name = "nidio-terraform-aws"
    vpc_security_group_ids = ["${aws_security_group.nidio-acesso-ssh-mngt.id}" ]
    subnet_id = aws_subnet.nidio_public_subnet_mngt.id
    user_data = <<-EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install software-properties-common -y
      sudo add-apt-repository --yes --update ppa:ansible/ansible -y
      sudo apt-get install ansible -y
    EOF
}
