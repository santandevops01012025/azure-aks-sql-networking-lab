variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Public IP. Must follow CAF naming standards (e.g., pip-appgw-dev)."

  validation {
    condition     = can(regex("^pip-[a-zA-Z0-9-]{1,76}$", var.name))
    error_message = "Public IP name must start with 'pip-' and contain alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Public IP."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Public IP will be created."
}

variable "allocation_method" {
  type        = string
  default     = "Static"
  description = "(Optional) Defines the allocation method for this IP address. Options: Static, Dynamic. Default is Static."

  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "allocation_method must be either 'Static' or 'Dynamic'."
  }
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "(Optional) The SKU of the Public IP. Options: Basic, Standard. Default is Standard."

  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "sku must be either 'Basic' or 'Standard'."
  }
}

variable "sku_tier" {
  type        = string
  default     = "Regional"
  description = "(Optional) The SKU Tier for this Public IP. Options: Regional, Global. Default is Regional."

  validation {
    condition     = contains(["Regional", "Global"], var.sku_tier)
    error_message = "sku_tier must be either 'Regional' or 'Global'."
  }
}

variable "zones" {
  type        = list(string)
  default     = ["1", "2", "3"]
  description = "(Optional) A collection containing the availability zone(s) to allocate the Public IP in (e.g. ['1', '2', '3'])."
}

variable "ddos_protection_mode" {
  type        = string
  default     = "VirtualNetworkInherited"
  description = "(Optional) DDoS protection mode for the Public IP. Options: Disabled, Enabled, VirtualNetworkInherited. Default is VirtualNetworkInherited."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "(Optional) Label for the Domain Name. Will be used to make the FQDN relative to the location specified."
}

variable "idle_timeout_in_minutes" {
  type        = number
  default     = 4
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. Default is 4."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Public IP."
}
