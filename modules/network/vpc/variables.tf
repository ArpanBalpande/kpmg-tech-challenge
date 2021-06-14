variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}
variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC."
}
variable "tags" {
  type        = map(string)
  description = " A map of tags to assign to the resource."
}