variable "plan_name" {
  type        = string
  description = "(Required) Name of the App Service Plan. Must follow CAF naming standards (e.g., asp-dev-eastus)."

  validation {
    condition     = can(regex("^asp-[a-zA-Z0-9-]{1,36}$", var.plan_name))
    error_message = "App Service Plan name must start with 'asp-' and contain alphanumeric characters or hyphens (max 40 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the App Service resources."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the App Service resources will be created."
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = "(Optional) The Operating System type for the plan. Options: Linux, Windows. Default is Linux."

  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "os_type must be either 'Linux' or 'Windows'."
  }
}

variable "sku_name" {
  type        = string
  default     = "P1v3"
  description = "(Optional) SKU name for the App Service Plan (e.g. B1, S1, P1v2, P1v3, P2v3, P3v3). Default is P1v3."
}

variable "worker_count" {
  type        = number
  default     = 1
  description = "(Optional) The number of Workers allocated to this App Service Plan. Default is 1."
}

variable "zone_balancing_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should Zone Balancing be enabled for high availability across Availability Zones? Default is false."
}

variable "web_apps" {
  type = map(object({
    https_only                    = optional(bool, true)
    public_network_access_enabled = optional(bool, false)
    virtual_network_subnet_id     = optional(string)
    app_settings                  = optional(map(string), {})

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), [])
    }), null)

    site_config = optional(object({
      always_on           = optional(bool, true)
      ftps_state          = optional(string, "Disabled")
      http2_enabled       = optional(bool, true)
      minimum_tls_version = optional(string, "1.2")
      application_stack = optional(object({
        node_version        = optional(string)
        python_version      = optional(string)
        dotnet_version      = optional(string)
        java_version        = optional(string)
        docker_image_name   = optional(string)
        docker_registry_url = optional(string)
      }), null)
    }), {})
  }))
  default     = {}
  description = "(Optional) Map of Web Apps to deploy under this App Service Plan."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resources."
}
