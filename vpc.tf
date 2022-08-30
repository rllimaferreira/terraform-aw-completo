resource "aws_vpc" "nidio_vpc" {
  cidr_block           = var.vpcCIDRblock #10.0.0.0/16
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name = "VPC nidio"
  }
} 

resource "aws_subnet" "nidio_public_subnet" {
  vpc_id                  = aws_vpc.nidio_vpc.id #10.0.1.0/24
  cidr_block              = var.publicsCIDRblock
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
  tags = {
   Name = "Public subnet"
  }
}

resource "aws_subnet" "nidio_public_subnet_mngt" {
  vpc_id                  = aws_vpc.nidio_vpc.id
  cidr_block              = var.mngtCIDRblock #10.0.3.0/24
  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
  tags = {
   Name = "Public subnet mngt"
  }
}

resource "aws_subnet" "nidio_private_subnet" {
  vpc_id                  = aws_vpc.nidio_vpc.id
  cidr_block              = var.privatesCIDRblock #10.0.2.0/24
  availability_zone       = var.availabilityZone

  tags = {
   Name = "Private subnet"
  }
}


resource "aws_internet_gateway" "nidio_igw" {
 vpc_id = aws_vpc.nidio_vpc.id
 tags = {
        Name = "Internet gateway nidio"
  }
}   

resource "aws_eip" "nidio_nat_eip" {
  vpc        = true
}

resource "aws_nat_gateway" "nidio_private_gw" {
  allocation_id = aws_eip.nidio_nat_eip.id #192.200.111.222
  subnet_id         = aws_subnet.nidio_public_subnet.id
}

resource "aws_route_table" "nidio_public_rt" {
 vpc_id = aws_vpc.nidio_vpc.id
    route {
        cidr_block = var.publicdestCIDRblock
        gateway_id = aws_internet_gateway.nidio_igw.id
    }
  tags = {
    Name = "Public Route table"
  }
}

resource "aws_route_table" "nidio_public_rt_mngt" {
 vpc_id = aws_vpc.nidio_vpc.id
    route {
        cidr_block = var.publicdestCIDRblock
        gateway_id = aws_internet_gateway.nidio_igw.id
    }
  tags = {
    Name = "Public MNGT Route table"
  }
}

resource "aws_route_table" "nidio_private_rt" {
 vpc_id = aws_vpc.nidio_vpc.id
route {
        cidr_block = var.publicdestCIDRblock
        nat_gateway_id = aws_nat_gateway.nidio_private_gw.id
    }
  tags = {
        Name = "Private Route table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.nidio_public_subnet.id
  route_table_id = aws_route_table.nidio_public_rt.id
}

resource "aws_route_table_association" "public_association_mngt" {
  subnet_id      = aws_subnet.nidio_public_subnet_mngt.id
  route_table_id = aws_route_table.nidio_public_rt_mngt.id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.nidio_private_subnet.id
  route_table_id = aws_route_table.nidio_private_rt.id
}