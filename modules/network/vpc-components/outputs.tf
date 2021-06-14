// VPC Outputs
output "id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}
output "arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.this.arn
}
output "cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}
output "instance_tenancy" {
  value = aws_vpc.this.instance_tenancy
}
output "tags_all" {
  value = aws_vpc.this.tags_all
}

// Public Subnet Outputs
output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}
output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}
output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.public[*].cidr_block
}

// Private Subnet Outputs
output "private_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.private[*].id
}
output "private_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.private[*].arn
}
output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.private[*].cidr_block
}

// Internet Gateway Outputs
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this[*].id
}
output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = aws_internet_gateway.this[*].arn
}
output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = aws_vpc.this.default_route_table_id
}

# Static values (arguments)
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.name
}

// Flow log
output "flow_log_id" {
  value = aws_flow_log.this.id
}

// Public Route Table ID
output "public_route_table_id" {
  value = aws_route_table.this[*].id
}