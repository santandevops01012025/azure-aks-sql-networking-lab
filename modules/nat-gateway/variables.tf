variable "name" {
  type        = string
  description = "(Required) Name of the Azure NAT Gateway. Must follow CAF naming standards (e.g., ng-dev-eastus)."

  validation {
    condition     = can(regex("^ng-[a-zA-Z0-9-]{1,77}$", var.name))
    error_message = "NAT Gateway name must start with 'ng-' and contain alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the NAT Gateway."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the NAT Gateway will be created."
}

variable "sku_name" {
  type        = string
  default     = "Standard"
  description = "(Optional) SKU Name of the NAT Gateway. Default is Standard."

  validation {
    condition     = contains(["Standard"], var.sku_name)
    error_message = "sku_name must be 'Standard'."
  }
}

variable "idle_timeout_in_minutes" {
  type        = number
  default     = 4
  description = "(Optional) The idle timeout in minutes for TCP connections. Valid values between 4 and 120. Default is 4."

  validation {
    condition     = var.idle_timeout_in_minutes >= 4 && var.idle_timeout_in_minutes <= 120
    error_message = "idle_timeout_in_minutes must be between 4 and 120."
  }
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of Availability Zones in which this NAT Gateway should be located (e.g., ['1'])."
}

variable "public_ip_address_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) List of Public IP Address Resource IDs to associate with this NAT Gateway."
}

variable "public_ip_prefix_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) List of Public IP Prefix Resource IDs to associate with this NAT Gateway."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) List of Subnet IDs to associate with this NAT Gateway."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Azure NAT Gateway."
}
