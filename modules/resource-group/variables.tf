variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group. Must follow Azure Cloud Adoption Framework (CAF) naming conventions."

  validation {
    condition     = can(regex("^(rg-|santan-)[a-zA-Z0-9-]{1,87}$", var.name))
    error_message = "Resource group name must start with 'rg-' or 'santan-' and contain only alphanumeric characters or hyphens (max 90 chars)."
  }
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Resource Group should exist."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Resource Group."
}

variable "managed_by" {
  type        = string
  default     = null
  description = "(Optional) The ID of the resource or user that manages this Resource Group."
}

variable "lock_level" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Lock Level for this Resource Group. Acceptable values are 'CanNotDelete' or 'ReadOnly'."

  validation {
    condition     = var.lock_level == null ? true : contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "The lock_level value must be either 'CanNotDelete' or 'ReadOnly'."
  }
}

variable "lock_name" {
  type        = string
  default     = null
  description = "(Optional) Specifies the name of the Resource Lock. Defaults to 'lock-<resource_group_name>' if not provided."
}
