variable "name" {
  type        = string
  description = "(Required) Name of the Key Vault. Must follow CAF naming standards (e.g., kv-dev-eastus)."

  validation {
    condition     = can(regex("^kv-[a-zA-Z0-9-]{1,21}$", var.name))
    error_message = "Key Vault name must start with 'kv-' and contain lower case alphanumeric characters or hyphens (between 3 and 24 chars total)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Key Vault."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Key Vault will be created."
}

variable "tenant_id" {
  type        = string
  description = "(Required) The Azure Active Directory (Entra ID) tenant ID that should be used for authenticating requests to the key vault."
}

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "(Optional) The Name of the SKU used for this Key Vault. Options: standard, premium. Default is standard."

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "sku_name must be either 'standard' or 'premium'."
  }
}

variable "enable_rbac_authorization" {
  type        = bool
  default     = true
  description = "(Optional) Boolean flag specifying whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization. Defaults to true."
}

variable "enabled_for_deployment" {
  type        = bool
  default     = false
  description = "(Optional) Boolean flag specifying whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets."
}

variable "enabled_for_disk_encryption" {
  type        = bool
  default     = true
  description = "(Optional) Boolean flag specifying whether Azure Disk Encryption is permitted to retrieve secrets and unwrap keys."
}

variable "enabled_for_template_deployment" {
  type        = bool
  default     = false
  description = "(Optional) Boolean flag specifying whether Azure Resource Manager is permitted to retrieve secrets."
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Is Purge Protection enabled for this Key Vault? Defaults to true."
}

variable "soft_delete_retention_days" {
  type        = number
  default     = 90
  description = "(Optional) The number of days that items should be retained for once soft-deleted. Default is 90."

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for this Key Vault. Defaults to false."
}

variable "network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default     = null
  description = "(Optional) Network ACL rules for the Key Vault."
}

variable "access_policies" {
  type = list(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
    storage_permissions     = optional(list(string), [])
  }))
  default     = []
  description = "(Optional) Access policies when enable_rbac_authorization is set to false."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Key Vault."
}
