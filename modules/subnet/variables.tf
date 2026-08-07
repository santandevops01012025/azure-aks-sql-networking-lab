variable "name" {
  type        = string
  description = "(Required) The name of the Subnet. Must follow CAF naming standards (e.g., snet-aks-dev) or Azure required names (e.g., AzureGatewaySubnet, AzureFirewallSubnet)."

  validation {
    condition     = can(regex("^(snet-[a-zA-Z0-9-]{1,75}|AzureGatewaySubnet|AzureFirewallSubnet|AzureBastionSubnet|GatewaySubnet)$", var.name))
    error_message = "Subnet name must start with 'snet-' or match Azure reserved subnet names (AzureGatewaySubnet, AzureFirewallSubnet, AzureBastionSubnet, GatewaySubnet)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Virtual Network exists."
}

variable "virtual_network_name" {
  type        = string
  description = "(Required) The name of the Virtual Network in which to create the Subnet."
}

variable "address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes for the Subnet in CIDR block notation, e.g., ['10.100.1.0/24']."

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "At least one CIDR address prefix must be specified in address_prefixes."
  }
}

variable "service_endpoints" {
  type        = list(string)
  default     = []
  description = "(Optional) The list of Service Endpoints to associate with the Subnet."
}

variable "service_endpoint_policy_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) The list of Service Endpoint Policy IDs to associate with the Subnet."
}

variable "private_endpoint_network_policies" {
  type        = string
  default     = "Disabled"
  description = "(Optional) Enable or Disable network policies for the private endpoint on the subnet. Default is 'Disabled'."

  validation {
    condition     = contains(["Enabled", "Disabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
    error_message = "The private_endpoint_network_policies value must be one of: 'Enabled', 'Disabled', 'NetworkSecurityGroupEnabled', 'RouteTableEnabled'."
  }
}

variable "private_link_service_network_policies_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Enable or Disable network policies for the private link service on the subnet. Default is true."
}

variable "delegation" {
  type = object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  })
  default     = null
  description = "(Optional) Configuration object for subnet service delegation."
}
