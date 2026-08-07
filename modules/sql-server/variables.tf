variable "name" {
  type        = string
  description = "(Required) Name of the Azure SQL Server. Must follow CAF naming standards (e.g., sql-dev-eastus)."

  validation {
    condition     = can(regex("^sql-[a-zA-Z0-9-]{1,59}$", var.name))
    error_message = "SQL Server name must start with 'sql-' and contain lower case alphanumeric characters or hyphens (max 63 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Azure SQL Server."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Azure SQL Server will be created."
}

variable "administrator_login" {
  type        = string
  default     = "sqladmin"
  description = "(Optional) The administrator login name for the SQL Server. Defaults to 'sqladmin'."
}

variable "administrator_login_password" {
  type        = string
  sensitive   = true
  description = "(Required) The administrator login password for the SQL Server."
}

variable "server_version" {
  type        = string
  default     = "12.0"
  description = "(Optional) The version for the new SQL Server. Valid value is '12.0'."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "(Optional) The Minimum TLS Version for all incoming network connections. Default is '1.2'."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for this server. Defaults to false for enterprise landing zone security."
}

variable "azuread_administrator" {
  type = object({
    login_username              = string
    object_id                   = string
    tenant_id                   = optional(string)
    azuread_authentication_only = optional(bool, false)
  })
  default     = null
  description = "(Optional) Configures Azure Active Directory Administrator for Microsoft Entra ID authentication."
}

variable "firewall_rules" {
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default     = {}
  description = "(Optional) Map of firewall rule configurations for the SQL Server."
}

variable "allow_azure_services" {
  type        = bool
  default     = false
  description = "(Optional) Whether to allow Azure services and resources to access this server (IP 0.0.0.0 rule)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the SQL Server."
}
