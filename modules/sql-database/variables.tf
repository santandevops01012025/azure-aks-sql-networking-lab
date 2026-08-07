variable "name" {
  type        = string
  description = "(Required) Name of the Azure SQL Database. Must follow CAF naming standards (e.g., sqldb-dev-eastus)."

  validation {
    condition     = can(regex("^sqldb-[a-zA-Z0-9-]{1,120}$", var.name))
    error_message = "SQL Database name must start with 'sqldb-' and contain alphanumeric characters or hyphens."
  }
}

variable "server_id" {
  type        = string
  description = "(Required) The Resource ID of the Azure SQL Server upon which to create the database."
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "(Optional) Specifies the collation of the database. Default is SQL_Latin1_General_CP1_CI_AS."
}

variable "sku_name" {
  type        = string
  default     = "S0"
  description = "(Optional) Specifies the name of the SKU used for the database (e.g., Basic, S0, P1, GP_Gen5_2, GP_S_Gen5_2). Default is 'S0'."
}

variable "max_size_gb" {
  type        = number
  default     = 32
  description = "(Optional) The max size of the database in gigabytes. Default is 32."
}

variable "zone_redundant" {
  type        = bool
  default     = false
  description = "(Optional) Whether or not this database is zone redundant. Default is false."
}

variable "read_scale" {
  type        = bool
  default     = false
  description = "(Optional) If enabled, connections that have ApplicationIntent=ReadOnly in their connection string may be routed to a read-only secondary replica."
}

variable "storage_account_type" {
  type        = string
  default     = "Local"
  description = "(Optional) Specifies the storage account type used to store backups for this database. Acceptable values are 'Geo', 'GeoZone', 'Local', or 'Zone'. Default is 'Local'."

  validation {
    condition     = contains(["Geo", "GeoZone", "Local", "Zone"], var.storage_account_type)
    error_message = "The storage_account_type must be one of: 'Geo', 'GeoZone', 'Local', 'Zone'."
  }
}

variable "auto_pause_delay_in_minutes" {
  type        = number
  default     = null
  description = "(Optional) Time in minutes before auto-pausing for Serverless databases (GP_S_* SKUs)."
}

variable "min_capacity" {
  type        = number
  default     = null
  description = "(Optional) Minimum vCores for Serverless databases (GP_S_* SKUs)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the SQL Database."
}
