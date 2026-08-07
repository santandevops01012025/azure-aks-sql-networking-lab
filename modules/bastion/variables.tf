variable "name" {
  type        = string
  description = "(Required) Name of the Azure Bastion Host. Must follow CAF naming standards (e.g., bas-dev-eastus)."

  validation {
    condition     = can(regex("^bas-[a-zA-Z0-9-]{1,76}$", var.name))
    error_message = "Bastion Host name must start with 'bas-' and contain alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Bastion Host."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the Bastion Host will be created."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The Resource ID of the subnet named 'AzureBastionSubnet' where the Bastion Host will be attached. Subnet mask must be /26 or larger."
}

variable "public_ip_address_id" {
  type        = string
  default     = null
  description = "(Optional) The Resource ID of the Public IP Address associated with this Bastion Host. Required for Basic, Standard, and Premium SKUs."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "(Optional) The SKU of the Bastion Host. Options: Developer, Basic, Standard, Premium. Default is Standard."

  validation {
    condition     = contains(["Developer", "Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be one of: 'Developer', 'Basic', 'Standard', or 'Premium'."
  }
}

variable "scale_units" {
  type        = number
  default     = 2
  description = "(Optional) The number of scale units for the Bastion Host. Valid between 2 and 50. Only applicable when sku is Standard or Premium. Default is 2."

  validation {
    condition     = var.scale_units >= 2 && var.scale_units <= 50
    error_message = "scale_units must be an integer between 2 and 50."
  }
}

variable "copy_paste_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Is Copy/Paste feature enabled for the Bastion Host? Defaults to true."
}

variable "file_copy_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Is File Copy feature enabled for the Bastion Host? Requires sku to be Standard or Premium. Defaults to true."
}

variable "ip_connect_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is IP Connect feature enabled for the Bastion Host? Requires sku to be Standard or Premium. Defaults to false."
}

variable "shareable_link_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Shareable Link feature enabled for the Bastion Host? Requires sku to be Standard or Premium. Defaults to false."
}

variable "tunneling_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Is Native Client Tunneling feature enabled (RDP/SSH via CLI)? Requires sku to be Standard or Premium. Defaults to true."
}

variable "kerberos_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Kerberos authentication enabled for the Bastion Host? Defaults to false."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Azure Bastion Host."
}
