variable "name" {
  type        = string
  description = "(Required) Name of the Storage Account. Must follow CAF naming standards (must start with 'st', contain only lowercase letters and numbers, 3 to 24 characters)."

  validation {
    condition     = can(regex("^st[a-z0-9]{1,22}$", var.name))
    error_message = "Storage Account name must start with 'st', contain only lowercase alphanumeric characters, and be between 3 and 24 characters long."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the Storage Account."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the Storage Account will be deployed."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "(Optional) Defines the Tier to use for this storage account. Options: Standard, Premium. Defaults to Standard."

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  type        = string
  default     = "ZRS"
  description = "(Optional) Defines the type of replication to use. Options: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS. Defaults to ZRS."

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "(Optional) Defines the Kind of account. Options: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2. Defaults to StorageV2."

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "account_kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2. Options: Hot, Cool. Defaults to Hot."

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "access_tier must be either 'Hot' or 'Cool'."
  }
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "(Optional) Minimum supported TLS version for HTTP requests. Defaults to TLS1_2."

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "min_tls_version must be TLS1_0, TLS1_1, or TLS1_2."
  }
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. Defaults to true."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for the Storage Account. Defaults to false for enterprise security."
}

variable "default_to_oauth_authentication" {
  type        = bool
  default     = true
  description = "(Optional) Default to Entra ID (OAuth) authentication in Azure Portal. Defaults to true."
}

variable "is_hns_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Hierarchical Namespace enabled (Azure Data Lake Storage Gen2)? Defaults to false."
}

variable "nfsv3_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is NFSv3 protocol enabled? Requires is_hns_enabled=true and account_tier=Premium. Defaults to false."
}

variable "large_file_shares_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Large File Shares enabled? Defaults to false."
}

variable "blob_properties" {
  type = object({
    versioning_enabled  = optional(bool, true)
    change_feed_enabled = optional(bool, false)
    delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), null)
    container_delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), null)
  })
  default     = null
  description = "(Optional) Blob service properties configuration."
}

variable "share_properties" {
  type = object({
    retention_policy = optional(object({
      days = optional(number, 7)
    }), null)
  })
  default     = null
  description = "(Optional) File Share service properties configuration."
}

variable "network_rules" {
  type = object({
    default_action             = optional(string, "Deny")
    bypass                     = optional(list(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default     = null
  description = "(Optional) Network rules restriction object for the Storage Account."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default     = null
  description = "(Optional) Managed Identity configuration for the storage account."
}

variable "containers" {
  type = map(object({
    container_access_type = optional(string, "private")
  }))
  default     = {}
  description = "(Optional) Map of storage containers to create."
}

variable "file_shares" {
  type = map(object({
    quota = optional(number, 5120)
  }))
  default     = {}
  description = "(Optional) Map of storage file shares to create."
}

variable "queues" {
  type        = list(string)
  default     = []
  description = "(Optional) List of storage queue names to create."
}

variable "tables" {
  type        = list(string)
  default     = []
  description = "(Optional) List of storage table names to create."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Storage Account."
}
