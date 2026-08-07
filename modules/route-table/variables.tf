variable "name" {
  type        = string
  description = "(Required) Name of the Route Table. Must follow CAF naming standards (e.g., rt-dev-eastus)."

  validation {
    condition     = can(regex("^rt-[a-zA-Z0-9-]{1,77}$", var.name))
    error_message = "Route Table name must start with 'rt-' and contain alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the Route Table."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Route Table will be created."
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Boolean flag specifying whether to enable BGP route propagation. Defaults to true."
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default     = []
  description = "(Optional) List of route objects to construct custom User Defined Routes (UDR)."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) List of Subnet IDs to associate with this Route Table."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Route Table."
}
