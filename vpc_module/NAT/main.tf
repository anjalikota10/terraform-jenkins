resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}