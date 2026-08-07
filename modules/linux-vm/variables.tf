variable "name" {
  type        = string
  description = "(Required) Name of the Linux Virtual Machine. Must follow CAF naming standards (e.g., vm-dev-eastus-01)."

  validation {
    condition     = can(regex("^vm-[a-zA-Z0-9-]{1,59}$", var.name))
    error_message = "Virtual Machine name must start with 'vm-' and contain only alphanumeric characters or hyphens (max 64 chars)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the Resource Group in which to deploy the Virtual Machine."
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Virtual Machine will be created."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The Subnet ID where the Primary Network Interface will be attached."
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2s"
  description = "(Optional) The SKU/size of the Virtual Machine. Default is Standard_B2s."
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "(Optional) The admin username for SSH authentication. Default is 'azureuser'."
}

variable "ssh_public_key" {
  type        = string
  default     = null
  description = "(Optional) The OpenSSH public key string for SSH authentication. Required if disable_password_authentication is true."
}

variable "admin_password" {
  type        = string
  sensitive   = true
  default     = null
  description = "(Optional) The admin password for authentication when disable_password_authentication is false."
}

variable "disable_password_authentication" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether password authentication is disabled. Set to true to require SSH key auth only. Defaults to false."
}

variable "create_public_ip" {
  type        = bool
  default     = false
  description = "(Optional) Determines whether to create and attach a Public IP to the VM network interface."
}

variable "zone" {
  type        = string
  default     = "1"
  description = "(Optional) Availability Zone in which to deploy the VM (e.g., '1', '2', or '3')."
}

variable "os_disk_type" {
  type        = string
  default     = "Premium_LRS"
  description = "(Optional) The type of storage account for the OS Managed Disk. Defaults to Premium_LRS."
}

variable "os_disk_size_gb" {
  type        = number
  default     = 30
  description = "(Optional) The size of the OS Managed Disk in GB. Defaults to 30."
}

variable "image_publisher" {
  type        = string
  default     = "Canonical"
  description = "(Optional) Publisher of the OS image."
}

variable "image_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "(Optional) Offer of the OS image."
}

variable "image_sku" {
  type        = string
  default     = "22_04-lts"
  description = "(Optional) SKU of the OS image."
}

variable "image_version" {
  type        = string
  default     = "latest"
  description = "(Optional) Version of the OS image."
}

variable "enable_boot_diagnostics" {
  type        = bool
  default     = true
  description = "(Optional) Enable Boot Diagnostics. Defaults to true (uses managed storage account)."
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  default     = null
  description = "(Optional) Custom Storage Account URI for Boot Diagnostics. If null and boot diagnostics is enabled, Azure managed storage is used."
}

variable "data_disks" {
  type = list(object({
    name                 = string
    disk_size_gb         = number
    storage_account_type = string
    lun                  = number
    caching              = string
  }))
  default     = []
  description = "(Optional) List of Managed Data Disks to create and attach to the Virtual Machine."
}

variable "custom_data" {
  type        = string
  default     = null
  description = "(Optional) Base64-encoded cloud-init custom data script."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the VM and associated resources."
}
