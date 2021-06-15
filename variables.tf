// Module "vpc" variables definitions
variable "vpc_name" {
  type        = string
  default     = ""
  description = "Name of the VPC to be used as identifier"
}
variable "vpc_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}
variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC."
}
variable "cloudwatch_log_group_name" {
  type        = string
  default     = ""
  description = "Name of the cloudwatch log group name"
}
variable "flow_logs_role_name" {
  type        = string
  default     = ""
  description = "Name of the IAM role to be used by VPC Flow log"
}
variable "flow_logs_policy_name" {
  type        = string
  default     = ""
  description = "Name of IAM policy to be used by VPC Flow log."
}
variable "public_subnets" {
  type        = list(string)
  default     = []
  description = "List of public_subnets to use"
}
variable "public_subnet_names" {
  type        = list(string)
  default     = []
  description = "name of public_subnets to use"
}
variable "public_route_table" {
  type        = string
  default     = ""
  description = "name of public_subnets to use"
}
variable "private_subnets" {
  type        = list(string)
  default     = []
  description = "List of public_subnets to use"
}
variable "private_subnet_names" {
  type        = list(string)
  default     = []
  description = "name of public_subnets to use"
}
variable "azs" {
  type        = list(string)
  default     = []
  description = "A list of availability zones names or ids in the region"
}
variable "vpc_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for the VPC"
}

// Module "natgateway" variables definitions
variable "natgateway_create" {
  type        = bool
  default     = false
  description = "value"
}
variable "nat_gateway_names" {
  type        = list(string)
  default     = []
  description = "value"
}
variable "destination_cidr_block" {
  type        = list(string)
  default     = []
  description = "value"
}
variable "public_asg_name" {
  type = string
}
variable "private_asg_name" {
  type = string
}