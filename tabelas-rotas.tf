resource "aws_route_table" "nidio_public_rt" {
 vpc_id = aws_vpc.nidio_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.nidio_igw.id
    }
  tags = {
    Name = "tabela de rotas publicas"
  }
}

resource "aws_route_table" "nidio_public_rt_mngt" {
 vpc_id = aws_vpc.nidio_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.nidio_igw.id
    }
    tags = {
        Name = "tabela de rotas publicas do MNGT"
  }
}

resource "aws_route_table" "nidio_private_rt" {
 vpc_id = aws_vpc.nidio_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nidio_nat_gateway.id
    }
    tags = {
        Name = "tabela de rotas privatas"
  }
}