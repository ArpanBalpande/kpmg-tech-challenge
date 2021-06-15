module "vpc" {
  // meta-arguments
  source = "./modules/network/vpc-components"
  // arguments
  name                      = var.vpc_name
  cidr                      = var.vpc_cidr
  instance_tenancy          = var.instance_tenancy
  cloudwatch_log_group_name = var.cloudwatch_log_group_name
  flow_logs_role_name       = var.flow_logs_role_name
  flow_logs_policy_name     = var.flow_logs_policy_name
  public_subnets            = var.public_subnets
  public_subnet_names       = var.public_subnet_names
  public_route_table        = var.public_route_table
  private_subnets           = var.private_subnets
  private_subnet_names      = var.private_subnet_names
  azs                       = var.azs
  destination_cidr_block    = var.destination_cidr_block
  nat_gateway_id            = module.natgateway[0].id
  tags                      = var.vpc_tags
}

module "natgateway" {
  // meta-arguments
  count  = var.natgateway_create ? length(var.nat_gateway_names) : 0
  source = "./modules/network/natgateway"
  // arguments
  nat_gateway_name = var.nat_gateway_names[count.index]
  nat_subnet_id    = module.vpc.public_subnet_ids[1]
  tags             = var.vpc_tags
}

module "loadbalancers" {
  // meta-arguments
  source = "./modules/compute/loadbalancers"
  // arguments
  vpc_id                         = module.vpc.id
  public_subnet_ids              = module.vpc.public_subnet_ids
  public_autoscaling_group_name  = var.public_asg_name
  private_subnet_ids             = module.vpc.private_subnet_ids
  private_autoscaling_group_name = var.private_asg_name
}

module "asg" {
  source   = "./modules/compute/ec2"
  asg_name = var.public_asg_name
  vpc_id   = module.vpc.id
  pub_subnet_id = module.vpc.public_subnet_ids[0]
}