variable "environment" {
  type        = string
  description = "Target deployment environment (e.g. dev, test, prod)."
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Primary Azure Region for resources."
  default     = "eastus"
}

variable "sql_location" {
  type        = string
  description = "Azure Region for the SQL Server and database."
  default     = "centralindia"
}

variable "workload" {
  type        = string
  description = "Workload or application identifier."
  default     = "enterprise"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "VNet address CIDR block."
  default     = ["10.10.0.0/16"]
}

variable "aks_node_count" {
  type        = number
  description = "Initial node count for AKS default pool."
  default     = 2
}

variable "aks_vm_size" {
  type        = string
  description = "VM size for AKS default node pool."
  default     = "Standard_D2s_v7"
}

variable "sql_admin_username" {
  type        = string
  description = "Administrator username for Azure SQL Server."
  default     = "sqladmin"
}

variable "sql_admin_password" {
  type        = string
  sensitive   = true
  description = "Administrator password for Azure SQL Server."
}

variable "tags" {
  type        = map(string)
  description = "Global tags to assign to all resources."
  default     = {}
}
