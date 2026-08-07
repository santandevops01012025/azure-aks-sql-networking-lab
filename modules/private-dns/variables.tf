variable "name" {
  type        = string
  description = "(Required) Name of the Private DNS Zone (e.g. privatelink.database.windows.net, privatelink.azurecr.io, privatelink.vaultcore.azure.net)."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the Private DNS Zone."
}

variable "vnet_links" {
  type = map(object({
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  default     = {}
  description = "(Optional) Map of Virtual Network Links to attach to this Private DNS Zone."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Private DNS Zone."
}
