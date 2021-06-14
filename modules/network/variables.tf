variable "instance_tenancy" {
  type    = string
  default = ""
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "cidr" {
  type = string
}
variable "name" {
  type = string
}
variable "cloudwatch_log_group_name" {
  type = string
}
variable "flow_logs_role_name" {
  type = string
}
variable "flow_logs_policy_name" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "public_route_table_names" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "public_subnet_names" {
  type = list(string)
}
variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}
variable "create_igw" {
  type    = bool
  default = true
}
variable "create_public_subnet" {
  type    = bool
  default = true
}
variable "create_natgateway" {
  description = "Controls if a natgateway is created"
  type        = bool
  default     = true
}
variable "nat_gateway_name" {
  description = "Name to be used on all the nat gateways as identifier"
  type        = string
  default     = ""
}
variable "nat_subnet_id" {
  description = "subnet id with which nat gateways would be related"
  type        = string
  default     = ""
}