output "id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the Resource Group."
}

output "name" {
  value       = azurerm_resource_group.this.name
  description = "The Name of the Resource Group."
}

output "location" {
  value       = azurerm_resource_group.this.location
  description = "The Azure Region location of the Resource Group."
}

output "lock_id" {
  value       = length(azurerm_management_lock.this) > 0 ? azurerm_management_lock.this[0].id : null
  description = "The ID of the Resource Group Management Lock, if applied."
}
