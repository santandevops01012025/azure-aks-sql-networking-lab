variable "name" {
  type        = string
  description = "(Required) Name of the Azure Container Registry. Must follow CAF naming standards and contain only alphanumeric characters (e.g., crdeveastus)."

  validation {
    condition     = can(regex("^cr[a-zA-Z0-9]{3,48}$", var.name))
    error_message = "ACR name must start with 'cr' and contain only alphanumeric characters (no hyphens), between 5 and 50 characters total."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Container Registry."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Container Registry will be created."
}

variable "sku" {
  type        = string
  default     = "Premium"
  description = "(Optional) The SKU name of the Container Registry. Options: Basic, Standard, Premium. Default is Premium."

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be one of: 'Basic', 'Standard', 'Premium'."
  }
}

variable "admin_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false for enterprise security."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for the Container Registry. Defaults to false for private endpoint landing zones."
}

variable "zone_redundancy_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Whether zone redundancy is enabled for the Container Registry (requires Premium SKU). Default is true."
}

variable "anonymous_pull_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether anonymous pull is enabled. Default is false."
}

variable "data_endpoint_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether dedicated data endpoints are enabled for the Container Registry. Default is false."
}

variable "georeplications" {
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool, true)
    tags                    = optional(map(string), {})
  }))
  default     = []
  description = "(Optional) A list of Azure locations where the Container Registry should be geo-replicated (requires Premium SKU)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Container Registry."
}
