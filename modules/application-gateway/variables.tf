variable "name" {
  type        = string
  description = "(Required) Name of the Application Gateway. Must follow CAF naming standards (e.g., agw-dev-eastus)."

  validation {
    condition     = can(regex("^(agw|appgw)-[a-zA-Z0-9-]{1,75}$", var.name))
    error_message = "Application Gateway name must start with 'agw-' or 'appgw-' (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Application Gateway."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Application Gateway will be created."
}

variable "sku" {
  type = object({
    name     = optional(string, "Standard_v2")
    tier     = optional(string, "Standard_v2")
    capacity = optional(number, 2)
  })
  default = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  description = "(Optional) SKU configuration object for Application Gateway Standard_v2 or WAF_v2."
}

variable "autoscale_configuration" {
  type = object({
    min_capacity = number
    max_capacity = number
  })
  default     = null
  description = "(Optional) Autoscale configuration for capacity (min_capacity 0-100, max_capacity 2-125)."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the dedicated Subnet where Application Gateway resides."
}

variable "public_ip_id" {
  type        = string
  description = "(Required) The ID of the Public IP resource associated with the Frontend IP configuration."
}

variable "identity_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) List of User Assigned Managed Identity IDs for Key Vault SSL certificate retrieval."
}

variable "frontend_ports" {
  type = list(object({
    name = string
    port = number
  }))
  default = [
    { name = "http-port", port = 80 },
    { name = "https-port", port = 443 }
  ]
  description = "(Required) Frontend ports list for HTTP/HTTPS listeners."
}

variable "backend_address_pools" {
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
  description = "(Required) Backend address pool configurations."
}

variable "backend_http_settings" {
  type = list(object({
    name                                = string
    cookie_based_affinity               = string
    port                                = number
    protocol                            = string
    request_timeout                     = number
    probe_name                          = optional(string)
    pick_host_name_from_backend_address = optional(bool, false)
  }))
  description = "(Required) Backend HTTP settings list."
}

variable "http_listeners" {
  type = list(object({
    name                         = string
    frontend_ip_config_name      = optional(string, "appgw-frontend-ip")
    frontend_port_name           = string
    protocol                     = string
    ssl_certificate_name         = optional(string)
    host_name                    = optional(string)
    host_names                   = optional(list(string))
    require_sni                  = optional(bool, false)
  }))
  description = "(Required) HTTP/HTTPS Listeners list."
}

variable "request_routing_rules" {
  type = list(object({
    name                        = string
    rule_type                   = string
    priority                    = number
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    url_path_map_name           = optional(string)
  }))
  description = "(Required) Request Routing Rules list."
}

variable "ssl_certificates" {
  type = list(object({
    name                = string
    key_vault_secret_id = optional(string)
    data                = optional(string)
    password            = optional(string)
  }))
  default     = []
  description = "(Optional) List of SSL Certificates from Key Vault or raw base64 data."
}

variable "probes" {
  type = list(object({
    name                                = string
    protocol                            = string
    path                                = string
    host                                = optional(string)
    pick_host_name_from_backend_http_settings = optional(bool, true)
    interval                            = number
    timeout                             = number
    unhealthy_threshold                 = number
  }))
  default     = []
  description = "(Optional) Custom Health Probes list."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the Application Gateway."
}
