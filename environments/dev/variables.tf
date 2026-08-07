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

variable "vm_name" {
  type        = string
  description = "Name of the Linux Virtual Machine."
  default     = "vm-backend-dev-01"
}

variable "vm_size" {
  type        = string
  description = "SKU/size of the Linux Virtual Machine."
  default     = "Standard_D2s_v7"
}

variable "vm_zone" {
  type        = string
  default     = null
  description = "(Optional) Availability Zone for the VM. Set to null if zones are not supported in the region."
}

variable "vm_create_public_ip" {
  type        = bool
  default     = true
  description = "Whether to create and attach a Public IP to the VM NIC."
}

variable "vm_admin_username" {
  type        = string
  description = "Admin username for the Linux Virtual Machine."
  default     = "azureuser"
}

variable "vm_admin_password" {
  type        = string
  sensitive   = true
  description = "Admin password for the Linux Virtual Machine."
}

variable "tags" {
  type        = map(string)
  description = "Global tags to assign to all resources."
  default     = {}
}
