variable "environment_name" {
  type        = string
  description = "(Required) Name of the Container App Environment. Must follow CAF naming standards (e.g., cae-dev-eastus)."

  validation {
    condition     = can(regex("^cae-[a-zA-Z0-9-]{1,76}$", var.environment_name))
    error_message = "Container App Environment name must start with 'cae-' and contain alphanumeric characters or hyphens (max 80 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Container App Environment."
}

variable "location" {
  type        = string
  description = "(Required) Azure Region where the resources will be deployed."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "(Optional) Resource ID of the Log Analytics Workspace for log integration."
}

variable "infrastructure_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) Existing Subnet ID to integrate Container App Environment into a Virtual Network."
}

variable "internal_load_balancer_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the Container App Environment be exposed internally only via Internal Load Balancer? Defaults to false."
}

variable "container_apps" {
  type = map(object({
    revision_mode = optional(string, "Single")

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), [])
    }), null)

    secrets = optional(list(object({
      name                = string
      value               = optional(string)
      identity            = optional(string)
      key_vault_secret_id = optional(string)
    })), [])

    registries = optional(list(object({
      server               = string
      username             = optional(string)
      password_secret_name = optional(string)
      identity             = optional(string)
    })), [])

    ingress = optional(object({
      external_enabled           = optional(bool, true)
      target_port                = number
      transport                  = optional(string, "auto")
      allow_insecure_connections = optional(bool, false)
      traffic_weight = optional(list(object({
        label           = optional(string)
        latest_revision = optional(bool, true)
        revision_suffix = optional(string)
        percentage      = number
      })), [{ latest_revision = true, percentage = 100 }])
    }), null)

    containers = list(object({
      name    = string
      image   = string
      cpu     = number
      memory  = string
      command = optional(list(string))
      args    = optional(list(string))
      env = optional(list(object({
        name        = string
        value       = optional(string)
        secret_name = optional(string)
      })), [])
    }))

    min_replicas = optional(number, 1)
    max_replicas = optional(number, 10)

    http_scale_rules = optional(list(object({
      name                = string
      concurrent_requests = number
    })), [])
  }))
  default     = {}
  description = "(Optional) Map of Container Apps to instantiate within the Container App Environment."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resources."
}
