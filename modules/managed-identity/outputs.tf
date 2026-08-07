output "id" {
  value       = azurerm_user_assigned_identity.this.id
  description = "The Resource ID of the User Assigned Managed Identity."
}

output "name" {
  value       = azurerm_user_assigned_identity.this.name
  description = "The Name of the User Assigned Managed Identity."
}

output "principal_id" {
  value       = azurerm_user_assigned_identity.this.principal_id
  description = "The Principal ID (Object ID) of the User Assigned Managed Identity."
}

output "client_id" {
  value       = azurerm_user_assigned_identity.this.client_id
  description = "The Client ID of the User Assigned Managed Identity."
}

output "tenant_id" {
  value       = azurerm_user_assigned_identity.this.tenant_id
  description = "The Tenant ID of the User Assigned Managed Identity."
}
