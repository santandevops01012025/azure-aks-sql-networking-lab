variable "name" {
  type        = string
  description = "(Required) Name of the Azure Cache for Redis. Must follow CAF naming standards (e.g., redis-dev-eastus)."

  validation {
    condition     = can(regex("^redis-[a-zA-Z0-9-]{1,57}$", var.name))
    error_message = "Redis Cache name must start with 'redis-' and contain alphanumeric characters or hyphens (max 63 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the Redis Cache."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the Redis Cache will be created."
}

variable "sku_name" {
  type        = string
  default     = "Standard"
  description = "(Optional) SKU of the Redis Cache. Options: Basic, Standard, Premium. Default is Standard."

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "sku_name must be one of: Basic, Standard, Premium."
  }
}

variable "capacity" {
  type        = number
  default     = 1
  description = "(Optional) The size of the Redis Cache SKU. Valid values: 0-6 for Basic/Standard, 1-5 for Premium. Default is 1."

  validation {
    condition     = var.capacity >= 0 && var.capacity <= 6
    error_message = "capacity must be an integer between 0 and 6."
  }
}

variable "family" {
  type        = string
  default     = "C"
  description = "(Optional) The SKU family to use. Options: C (Basic/Standard), P (Premium). Default is C."

  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "family must be either 'C' or 'P'."
  }
}

variable "non_ssl_port_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enable the non-SSL port (6379). Defaults to false for enterprise security."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "(Optional) The minimum TLS version. Options: 1.0, 1.1, 1.2. Default is 1.2."

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "minimum_tls_version must be '1.0', '1.1', or '1.2'."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for the Redis Cache. Defaults to false."
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The Subnet ID to deploy the Redis Cache in. Only supported for Premium SKU."
}

variable "private_static_ip_address" {
  type        = string
  default     = null
  description = "(Optional) Static IP address within the subnet to assign to Redis Cache (Premium SKU with subnet_id)."
}

variable "redis_configuration" {
  type = object({
    maxmemory_reserved              = optional(number)
    maxmemory_delta                 = optional(number)
    maxmemory_policy                = optional(string, "volatile-lru")
    rdb_backup_enabled              = optional(bool, false)
    rdb_backup_frequency            = optional(number)
    rdb_backup_max_snapshot_count   = optional(number)
    rdb_storage_connection_string   = optional(string)
    aof_backup_enabled              = optional(bool, false)
    aof_storage_connection_string_0 = optional(string)
    aof_storage_connection_string_1 = optional(string)
  })
  default     = null
  description = "(Optional) Redis configuration settings object."
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default     = null
  description = "(Optional) Managed Identity configuration for Redis Cache."
}

variable "patch_schedule" {
  type = list(object({
    day_of_week        = string
    start_hour_utc     = optional(number, 0)
    maintenance_window = optional(string)
  }))
  default     = []
  description = "(Optional) List of patch schedule window objects."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Redis Cache."
}
