// "" module variables values
vpc_name                  = "KPMG-VPC"
vpc_cidr                  = "10.0.0.0/16"
instance_tenancy          = "default"
cloudwatch_log_group_name = "cloudwatch_log_group"
flow_logs_role_name       = "flow_logs_role"
flow_logs_policy_name     = "flow_logs_policy"
azs                       = ["us-east-2a", "us-east-2b"]
public_subnets            = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_names       = ["AZ1_Public_Subnet", "AZ2_Public_Subnet"]
private_subnets           = ["10.0.3.0/24", "10.0.4.0/24"]
private_subnet_names      = ["AZ1_Private_Subnet", "AZ2_Private_Subnet"]
public_route_table        = "Public_RT"
destination_cidr_block    = ["0.0.0.0/0"]
vpc_tags = {
  Purpose = "Tech-Challenge"
}

// "natgateway" module variables values
natgateway_create = true
nat_gateway_names = ["NAT-GW-External"]

// "loadbalancers" module variables values

// "ec2" module variables values
public_asg_name  = "kpmg-asg-pub"
private_asg_name = "kpmg-asg-pri"