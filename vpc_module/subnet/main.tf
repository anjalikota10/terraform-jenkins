resource "aws_subnet" "this" {
  count = length(var.cidr_blocks)
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = var.public
}

output "subnet_ids" {
  value = aws_subnet.this[*].id
}
