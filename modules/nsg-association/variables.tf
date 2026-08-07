variable "network_security_group_id" {
  type        = string
  description = "(Required) The ID of the Network Security Group to associate."
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Subnet to associate with the Network Security Group."
}

variable "network_interface_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Network Interface (NIC) to associate with the Network Security Group."
}
