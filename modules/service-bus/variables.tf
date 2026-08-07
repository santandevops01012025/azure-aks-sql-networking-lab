variable "name" {
  type        = string
  description = "(Required) Name of the Service Bus Namespace. Must follow CAF naming standards (e.g., sb-dev-eastus)."

  validation {
    condition     = can(regex("^sb-[a-zA-Z0-9-]{1,47}$", var.name))
    error_message = "Service Bus Namespace name must start with 'sb-' and contain alphanumeric characters or hyphens (max 50 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the Service Bus Namespace."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the Service Bus Namespace will be created."
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "(Optional) Defines which tier to use. Options: Basic, Standard, Premium. Default is Standard."

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be one of: Basic, Standard, Premium."
  }
}

variable "capacity" {
  type        = number
  default     = 0
  description = "(Optional) Messaging units for Premium SKU. Options: 1, 2, 4, 8, 16. Defaults to 0 (non-Premium)."

  validation {
    condition     = contains([0, 1, 2, 4, 8, 16], var.capacity)
    error_message = "capacity must be 0 (for Basic/Standard), or 1, 2, 4, 8, 16 (for Premium)."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for the Service Bus Namespace. Defaults to false."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "(Optional) Minimum TLS version for requests. Options: 1.0, 1.1, 1.2. Defaults to 1.2."

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "minimum_tls_version must be '1.0', '1.1', or '1.2'."
  }
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default     = null
  description = "(Optional) Managed Identity configuration for Service Bus."
}

variable "queues" {
  type = map(object({
    enable_partitioning                  = optional(bool, false)
    max_size_in_megabytes                = optional(number, 1024)
    requires_duplicate_detection         = optional(bool, false)
    requires_session                     = optional(bool, false)
    dead_lettering_on_message_expiration = optional(bool, true)
    max_delivery_count                   = optional(number, 10)
    lock_duration                        = optional(string, "PT1M")
    default_message_ttl                  = optional(string, "P14D")
    auto_delete_on_idle                  = optional(string)
  }))
  default     = {}
  description = "(Optional) Map of Service Bus Queues to create."
}

variable "topics" {
  type = map(object({
    enable_partitioning          = optional(bool, false)
    max_size_in_megabytes        = optional(number, 1024)
    requires_duplicate_detection = optional(bool, false)
    default_message_ttl          = optional(string, "P14D")
    auto_delete_on_idle          = optional(string)
    subscriptions = optional(map(object({
      max_delivery_count                   = optional(number, 10)
      dead_lettering_on_message_expiration = optional(bool, true)
      lock_duration                        = optional(string, "PT1M")
      requires_session                     = optional(bool, false)
      default_message_ttl                  = optional(string, "P14D")
    })), {})
  }))
  default     = {}
  description = "(Optional) Map of Service Bus Topics and nested Subscriptions to create."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Service Bus Namespace."
}
