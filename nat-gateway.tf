resource "aws_nat_gateway" "nidio_nat_gateway" {
  allocation_id = aws_eip.nidio_nat_eip.id 
  subnet_id = aws_subnet.nidio_public_subnet.id
  connectivity_type = "public"
}