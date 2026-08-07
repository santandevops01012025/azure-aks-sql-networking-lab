output "id" {
  value       = azurerm_log_analytics_workspace.this.id
  description = "The Resource ID of the Log Analytics Workspace."
}

output "name" {
  value       = azurerm_log_analytics_workspace.this.name
  description = "The Name of the Log Analytics Workspace."
}

output "workspace_id" {
  value       = azurerm_log_analytics_workspace.this.workspace_id
  description = "The Workspace GUID (ID) of the Log Analytics Workspace."
}

output "primary_shared_key" {
  value       = azurerm_log_analytics_workspace.this.primary_shared_key
  sensitive   = true
  description = "The Primary Shared Key for the Log Analytics Workspace."
}

output "secondary_shared_key" {
  value       = azurerm_log_analytics_workspace.this.secondary_shared_key
  sensitive   = true
  description = "The Secondary Shared Key for the Log Analytics Workspace."
}
