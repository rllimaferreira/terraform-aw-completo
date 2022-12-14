#instando = VM
resource "aws_instance" "front_nidio-ec2" {
  #falando pra criar dois recursos
  count = 2
  #a Amazon Machine Image que será usada
  ami = "ami-085284d24fe829cd0"
  #tipo da instancia, ou seja o tipo de hardware que será usado
  instance_type = "t2.micro"
  #tag Name nomeia
  tags = {
    #aqui estamos fazendo um concatenação de de string do texto
    #que digitamos e o numero do contador(count) como falamos para criar
    #2 recursos desse e começa em 0 ficará assim
    #uma VM com o nome de: front_nidio-ec2-0
    # a outra como front_nidio-ec2-1
    Name = "front_nidio-ec2-${count.index}"
  }
  #passando a chave que vamos usar, é a mesma que nós subimos em keypair
  key_name = "nidio-terraform-aws"
  #solicitando o vinculo com um IP publico
  associate_public_ip_address = true
  #aqui fazemos o vinculo com os grupos de segurança
  #se reparar estamos pedindo o grupo nidio_sg_ssh(libera a porta 22 para dentro da VPC)
  # e o nidio_sg_web(libera a porta 80 para ser acessivel pela web)
  vpc_security_group_ids = ["${aws_security_group.nidio-acesso-ssh-private.id}","${aws_security_group.nidio-acesso-web.id}" ]
  #vinculando nossa instancia(VM) a subrede publica
  subnet_id = aws_subnet.nidio_public_subnet.id
  #tem a mesma função do dados do usuário no console web da AWS
  #no caso estamos fazendo o update dos repositório
  #instalação do apache e git clone no projeto Mulher Maravilha
  #e colando na pasta padrão do apache
  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt-get update
  #   sudo apt-get install apache2 -y
  #   sudo git clone https://github.com/ibsonjunior/Mulher_Maravilha.git
  #   sudo chmod 777 -R Mulher_Maravilha/
  #   sudo cp -rf Mulher_Maravilha/* /var/www/html/
  # EOF

}

#recursos semelhante as do anterior, mas sem IP publico
resource "aws_instance" "back_nidio-ec2" {
  #troquei a ordem da tag e não muda nada continua nomeando
  tags = {
    Name = "back_nidio-ec2-${count.index}"
  }
  count = 1
  ami = "ami-085284d24fe829cd0"
  instance_type = "t2.micro"
  key_name = "nidio-terraform-aws"
  #ligando a subrede Privada
  subnet_id = aws_subnet.nidio_private_subnet.id
  #apenas o SG nidio_sg_ssh(libera a porta 22 para dentro da VPC)
  vpc_security_group_ids = ["${aws_security_group.nidio-acesso-ssh-private.id}" ]
    
}

resource "aws_instance" "mngt_nidio-ec2" {
  count = 1
  ami = "ami-085284d24fe829cd0"
  instance_type = "t2.micro"
  tags = {
    Name = "mngt_nidio-ec2-${count.index}"
  }
  key_name = "nidio-terraform-aws"
  #apenas o SG nidio_sg_ssh-mngt(libera a porta 22 para internet)
  vpc_security_group_ids = ["${aws_security_group.nidio-acesso-ssh-mngt.id}" ]
  subnet_id = aws_subnet.nidio_public_subnet_mngt.id
  #usando o dados do usuário para instalar o ansible para nós
  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository --yes --update ppa:ansible/ansible -y
    sudo apt-get install ansible -y
  EOF
}
