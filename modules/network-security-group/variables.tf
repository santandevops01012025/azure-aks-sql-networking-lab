variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Network Security Group. Must follow CAF naming standards (e.g., nsg-dev-eastus)."

  validation {
    condition     = can(regex("^nsg-[a-zA-Z0-9-]{1,76}$", var.name))
    error_message = "Network Security Group name must start with 'nsg-' and contain only alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Network Security Group."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Network Security Group will be created."
}

variable "rules" {
  type = list(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = optional(string)
    source_port_ranges          = optional(list(string))
    destination_port_range      = optional(string)
    destination_port_ranges     = optional(list(string))
    source_address_prefix       = optional(string)
    source_address_prefixes     = optional(list(string))
    destination_address_prefix  = optional(string)
    destination_address_prefixes = optional(list(string))
    description                 = optional(string)
  }))
  default     = []
  description = "(Optional) List of security rule objects to define within the Network Security Group."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Network Security Group."
}
