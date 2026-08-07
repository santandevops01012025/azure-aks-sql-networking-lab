output "id" {
  value       = azurerm_network_security_group.this.id
  description = "The ID of the Network Security Group."
}

output "name" {
  value       = azurerm_network_security_group.this.name
  description = "The Name of the Network Security Group."
}

output "resource_group_name" {
  value       = azurerm_network_security_group.this.resource_group_name
  description = "The Resource Group Name of the Network Security Group."
}

output "location" {
  value       = azurerm_network_security_group.this.location
  description = "The Azure Region of the Network Security Group."
}
