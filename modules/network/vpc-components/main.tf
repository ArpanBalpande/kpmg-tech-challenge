########
# VPC #
#######

resource "aws_vpc" "this" {
  cidr_block       = var.cidr
  instance_tenancy = var.instance_tenancy

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

#############
# Flow Logs #
#############
resource "aws_cloudwatch_log_group" "this" { #tfsec:ignore:AWS089
  name = var.cloudwatch_log_group_name
}
resource "aws_iam_role" "this" {
  name               = var.flow_logs_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "this" {
  name   = var.flow_logs_policy_name
  role   = aws_iam_role.this.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_flow_log" "this" {
  iam_role_arn    = aws_iam_role.this.arn
  log_destination = aws_cloudwatch_log_group.this.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this.id
  tags            = var.tags
}

########################
# Default Route Table #
########################

resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = merge(
    {
      "Name" = "Private_RT"
    },
    var.tags,
  )
}

resource "aws_route" "private" {
  count                  = length(var.destination_cidr_block)
  route_table_id         = aws_vpc.this.default_route_table_id
  destination_cidr_block = var.destination_cidr_block[count.index]
  nat_gateway_id         = var.nat_gateway_id
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}
################
# Publiс routes
################
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = var.public_route_table
    },
    var.tags,
  )
}
resource "aws_route" "public" {
  count = var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[count.index].id
}

################
# Public subnet
################
resource "aws_subnet" "public" {
  count = var.create_public_subnet ? length(var.public_subnets) : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(concat(var.public_subnets, [""]), count.index)
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      "Name" = var.public_subnet_names[count.index]
    },
    var.tags,
  )
}
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.this.id
}


################
# Private subnet
################
resource "aws_subnet" "private" {
  count = var.create_private_subnet ? length(var.private_subnets) : 0

  vpc_id               = aws_vpc.this.id
  cidr_block           = element(concat(var.private_subnets, [""]), count.index)
  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = merge(
    {
      "Name" = var.private_subnet_names[count.index]
    },
    var.tags,
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_default_route_table.this.id
}