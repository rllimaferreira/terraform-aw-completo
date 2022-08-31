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