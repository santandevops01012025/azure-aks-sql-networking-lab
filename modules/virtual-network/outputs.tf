output "id" {
  value       = azurerm_virtual_network.this.id
  description = "The ID of the Virtual Network."
}

output "name" {
  value       = azurerm_virtual_network.this.name
  description = "The Name of the Virtual Network."
}

output "resource_group_name" {
  value       = azurerm_virtual_network.this.resource_group_name
  description = "The Resource Group Name of the Virtual Network."
}

output "location" {
  value       = azurerm_virtual_network.this.location
  description = "The Azure Region of the Virtual Network."
}

output "address_space" {
  value       = azurerm_virtual_network.this.address_space
  description = "The address space list of the Virtual Network."
}

output "guid" {
  value       = azurerm_virtual_network.this.guid
  description = "The GUID of the Virtual Network."
}
