module "vpc" {
  // meta-arguments
  source = "./modules/network/vpc"
  // arguments
  name                      = var.vpc_name
  cidr                      = var.vpc_cidr
  instance_tenancy          = var.instance_tenancy
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  flow_logs_role_name       = var.flow_logs_role_name
  flow_logs_policy_name     = var.flow_logs_policy_name
  public_subnets            = var.public_subnets
  public_subnet_names       = var.public_subnet_names
  public_route_table_names  = var.public_route_table_names
  azs                       = var.azs
  tags                      = var.vpc_tags
}