variable "name" {
  type        = string
  description = "(Required) Name of the User Assigned Managed Identity. Must follow CAF naming standards (e.g., id-dev-eastus)."

  validation {
    condition     = can(regex("^(id|mi)-[a-zA-Z0-9-]{1,125}$", var.name))
    error_message = "Managed Identity name must start with 'id-' or 'mi-' and contain alphanumeric characters or hyphens (max 128 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Managed Identity."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Managed Identity will be created."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Managed Identity."
}
