module "vpc" {
  source           = "./modules/network/vpc"
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags             = var.vpc_tags
}