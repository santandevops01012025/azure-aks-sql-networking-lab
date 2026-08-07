output "id" {
  value       = azurerm_application_gateway.this.id
  description = "The Resource ID of the Application Gateway."
}

output "name" {
  value       = azurerm_application_gateway.this.name
  description = "The Name of the Application Gateway."
}

output "frontend_ip_configuration" {
  value       = azurerm_application_gateway.this.frontend_ip_configuration
  description = "The Frontend IP configuration details of the Application Gateway."
}

output "backend_address_pool" {
  value       = azurerm_application_gateway.this.backend_address_pool
  description = "List of Backend Address Pools defined within the Application Gateway."
}
