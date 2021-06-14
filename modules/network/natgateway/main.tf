
###############
# NAT Gateway #
###############

resource "aws_eip" "this" {
  vpc = true

  tags = merge(
    {
      "Name" = var.nat_gateway_name
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.nat_subnet_id

  tags = merge(
    {
      "Name" = var.nat_gateway_name
    },
    var.tags,
  )
}