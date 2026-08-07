output "id" {
  value       = azurerm_private_endpoint.this.id
  description = "The Resource ID of the Private Endpoint."
}

output "name" {
  value       = azurerm_private_endpoint.this.name
  description = "The Name of the Private Endpoint."
}

output "private_ip_address" {
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
  description = "The Private IP Address assigned to this Private Endpoint."
}

output "private_service_connection" {
  value       = azurerm_private_endpoint.this.private_service_connection
  description = "The Private Service Connection block details."
}
