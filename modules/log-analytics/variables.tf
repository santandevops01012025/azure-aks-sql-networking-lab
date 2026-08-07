variable "name" {
  type        = string
  description = "(Required) Name of the Log Analytics Workspace. Must follow CAF naming standards (e.g., log-dev-eastus)."

  validation {
    condition     = can(regex("^log-[a-zA-Z0-9-]{1,59}$", var.name))
    error_message = "Log Analytics Workspace name must start with 'log-' and contain lower case alphanumeric characters or hyphens (max 63 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Log Analytics Workspace."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Log Analytics Workspace will be created."
}

variable "sku" {
  type        = string
  default     = "PerGB2018"
  description = "(Optional) Specifies the SKU of the Log Analytics Workspace. Options: PerGB2018, CapacityReservation. Default is PerGB2018."
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "(Optional) The workspace data retention in days. Possible values are between 30 and 730. Default is 30."

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "retention_in_days must be between 30 and 730 days."
  }
}

variable "daily_quota_gb" {
  type        = number
  default     = -1
  description = "(Optional) The workspace daily volume cap for ingestion in GB. Defaults to -1 (unlimited)."
}

variable "internet_ingestion_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Should the Log Analytics Workspace support ingestion over the public internet. Default is true."
}

variable "internet_query_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Should the Log Analytics Workspace support querying over the public internet. Default is true."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Log Analytics Workspace."
}
