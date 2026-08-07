variable "name" {
  type        = string
  description = "(Required) Name of the Azure Kubernetes Service (AKS) cluster. Must follow CAF naming standards (e.g., aks-dev-eastus)."

  validation {
    condition     = can(regex("^aks-[a-zA-Z0-9-]{1,59}$", var.name))
    error_message = "AKS cluster name must start with 'aks-' and contain alphanumeric characters or hyphens (max 63 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to create the AKS cluster."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the AKS cluster will be created."
}

variable "dns_prefix" {
  type        = string
  description = "(Required) DNS prefix specified when creating the managed cluster."
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "(Optional) Version of Kubernetes specified when creating the AKS cluster."
}

variable "sku_tier" {
  type        = string
  default     = "Standard"
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Options: Free, Standard, Premium. Default is Standard."

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be one of: 'Free', 'Standard', 'Premium'."
  }
}

variable "default_node_pool" {
  type = object({
    name                = string
    vm_size             = string
    node_count          = optional(number, 3)
    enable_auto_scaling = optional(bool, true)
    min_count           = optional(number, 1)
    max_count           = optional(number, 5)
    vnet_subnet_id      = optional(string)
    os_disk_size_gb     = optional(number, 128)
    zones               = optional(list(string), ["1", "2", "3"])
    type                = optional(string, "VirtualMachineScaleSets")
  })
  default = {
    name    = "agentpool"
    vm_size = "Standard_D2s_v5"
  }
  description = "(Required) Configuration object for the default system node pool."
}

variable "vnet_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of a Subnet where the Kubernetes default node pool should be attached."
}


variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "(Optional) Type of Managed Identity. Default is 'SystemAssigned'."
}

variable "user_assigned_identity_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the User Assigned Identity when identity_type is 'UserAssigned'."
}

variable "network_plugin" {
  type        = string
  default     = "azure"
  description = "(Optional) Network plugin used for building the Kubernetes network. Options: 'azure', 'kubenet', 'none'. Default is 'azure'."
}

variable "network_policy" {
  type        = string
  default     = "azure"
  description = "(Optional) Network policy used for building the Kubernetes network. Options: 'azure', 'calico', 'cilium'. Default is 'azure'."
}

variable "service_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "(Optional) The Network Range used for the Kubernetes service IPs. Default is '172.16.0.0/16'."
}

variable "dns_service_ip" {
  type        = string
  default     = "172.16.0.10"
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "(Optional) ID of Log Analytics Workspace for Container Insights integration."
}

variable "oidc_issuer_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Enable OIDC issuer URL for workload identity integration. Default is true."
}

variable "workload_identity_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Enable Workload Identity. Default is true."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the AKS cluster."
}
