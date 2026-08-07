variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Virtual Network. Must follow CAF naming conventions (e.g., vnet-dev-eastus)."

  validation {
    condition     = can(regex("^vnet-[a-zA-Z0-9-]{1,59}$", var.name))
    error_message = "Virtual Network name must start with 'vnet-' and contain only alphanumeric characters or hyphens (max 64 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where the Virtual Network will be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Virtual Network should exist."
}

variable "address_space" {
  type        = list(string)
  description = "(Required) The address space that is used by the Virtual Network in CIDR notation, e.g., ['10.0.0.0/16']."

  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one CIDR address prefix must be specified for address_space."
  }
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "(Optional) List of IP addresses of DNS servers used by the Virtual Network."
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default     = null
  description = "(Optional) Configures Azure DDoS Protection Plan integration for the VNet."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Virtual Network."
}
