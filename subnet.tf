resource "aws_subnet" "nidio_public_subnet" {
  vpc_id                  = aws_vpc.nidio_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true 
  availability_zone       = "us-west-1a"
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_subnet" "nidio_public_subnet_mngt" {
  vpc_id                  = aws_vpc.nidio_vpc.id
  cidr_block              = "10.0.3.0/24" 
  map_public_ip_on_launch = true 
  availability_zone       = "us-west-1a"
  tags = {
    Name = "Public subnet mngt"
  }
}

resource "aws_subnet" "nidio_private_subnet" {
  vpc_id                  = aws_vpc.nidio_vpc.id
  cidr_block              = "10.0.2.0/24" 
  availability_zone       = "us-west-1a"
  tags = {
    Name = "Private subnet"
  }
}