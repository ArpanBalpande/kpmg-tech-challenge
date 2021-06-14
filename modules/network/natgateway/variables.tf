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
variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}