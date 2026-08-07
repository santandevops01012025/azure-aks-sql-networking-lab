output "id" {
  value       = azurerm_subnet.this.id
  description = "The ID of the Subnet."
}

output "name" {
  value       = azurerm_subnet.this.name
  description = "The Name of the Subnet."
}

output "address_prefixes" {
  value       = azurerm_subnet.this.address_prefixes
  description = "The Address Prefixes assigned to the Subnet."
}

output "virtual_network_name" {
  value       = azurerm_subnet.this.virtual_network_name
  description = "The Virtual Network Name where the Subnet resides."
}

output "resource_group_name" {
  value       = azurerm_subnet.this.resource_group_name
  description = "The Resource Group Name of the Subnet."
}
