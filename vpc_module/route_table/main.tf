resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
}

resource "aws_route" "this" {
  route_table_id = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"

  # Conditionally set gateway_id or nat_gateway_id
  gateway_id      = var.public ? var.igw_id : null
  nat_gateway_id  = var.public ? null : var.nat_gateway_id
}

resource "aws_route_table_association" "this" {
  count = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.this.id
}
