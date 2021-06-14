// "" module variables values
vpc_name                  = "KPMG-VPC"
vpc_cidr                  = "10.131.0.0/16"
instance_tenancy          = "default"
cloudwatch_log_group_name = "cloudwatch_log_group"
flow_logs_role_name       = "flow_logs_role"
flow_logs_policy_name     = "flow_logs_policy"
azs                       = ["us-east-1a"]
public_subnets            = ["10.131.99.0/24"]
public_subnet_names       = ["AZ1_Public_Subnet"]
public_route_table_names  = ["Public"]
vpc_tags = {
  Purpose = "Tech-Challenge"
}

// "natgateway" module variables values
natgateway_create = true
nat_gateway_names = ["NAT-GW-External"]