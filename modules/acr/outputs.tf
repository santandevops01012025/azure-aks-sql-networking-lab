output "id" {
  value       = azurerm_container_registry.this.id
  description = "The Resource ID of the Container Registry."
}

output "name" {
  value       = azurerm_container_registry.this.name
  description = "The Name of the Container Registry."
}

output "login_server" {
  value       = azurerm_container_registry.this.login_server
  description = "The URL that can be used to log into the container registry (e.g. crdeveastus.azurecr.io)."
}

output "admin_username" {
  value       = azurerm_container_registry.this.admin_username
  sensitive   = true
  description = "The Username used for Admin authentication if admin_enabled is true."
}

output "admin_password" {
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
  description = "The Password used for Admin authentication if admin_enabled is true."
}
