output "id" {
  value       = azurerm_nat_gateway.this.id
  description = "The Resource ID of the Azure NAT Gateway."
}

output "name" {
  value       = azurerm_nat_gateway.this.name
  description = "The Name of the Azure NAT Gateway."
}

output "resource_guid" {
  value       = azurerm_nat_gateway.this.resource_guid
  description = "The Resource GUID of the Azure NAT Gateway."
}
