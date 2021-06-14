output "id" {
  description = "The ID of the Nat Gateways"
  value       = aws_nat_gateway.this.id
}

output "allocation_id" {
  description = "Allocation_id pf the Nat Gateways"
  value       = aws_nat_gateway.this.allocation_id
}

output "private_ip" {
  description = "The CIDR block of the VPC"
  value       = aws_eip.this.private_ip
}

output "public_ip" {
  description = "List of IDs of public subnets"
  value       = aws_eip.this.public_ip
}