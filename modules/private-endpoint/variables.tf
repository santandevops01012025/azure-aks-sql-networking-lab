variable "name" {
  type        = string
  description = "(Required) Name of the Private Endpoint. Must follow CAF naming standards (e.g., pe-kv-dev-eastus)."

  validation {
    condition     = can(regex("^pe-[a-zA-Z0-9-]{1,77}$", var.name))
    error_message = "Private Endpoint name must start with 'pe-' and contain alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the Private Endpoint."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Private Endpoint will be created."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP addresses will be allocated for this Private Endpoint."
}

variable "private_connection_resource_id" {
  type        = string
  description = "(Required) The Resource ID of the target Azure PaaS Service (e.g. Key Vault, SQL Server, Storage Account, ACR)."
}

variable "subresource_names" {
  type        = list(string)
  description = "(Required) A list of subresource names which the Private Endpoint is able to connect to (e.g. ['vault'], ['sqlServer'], ['blob'], ['registry'])."
}

variable "is_manual_connection" {
  type        = bool
  default     = false
  description = "(Optional) Does the Private Endpoint require manual approval from the remote resource owner? Default is false."
}

variable "private_dns_zone_group" {
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
  default     = null
  description = "(Optional) Configuration block for Private DNS Zone integration."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Private Endpoint."
}
