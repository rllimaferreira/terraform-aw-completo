resource "aws_internet_gateway" "nidio_igw" {
 vpc_id = aws_vpc.nidio_vpc.id
 tags = {
    Name = "Internet gateway nidio"
  }
}