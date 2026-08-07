output "id" {
  value       = azurerm_servicebus_namespace.this.id
  description = "The Resource ID of the Service Bus Namespace."
}

output "name" {
  value       = azurerm_servicebus_namespace.this.name
  description = "The Name of the Service Bus Namespace."
}

output "endpoint" {
  value       = azurerm_servicebus_namespace.this.endpoint
  description = "The Primary Endpoint URL of the Service Bus Namespace."
}

output "primary_connection_string" {
  value       = azurerm_servicebus_namespace.this.default_primary_connection_string
  sensitive   = true
  description = "The Primary Connection String for the Service Bus Namespace."
}

output "secondary_connection_string" {
  value       = azurerm_servicebus_namespace.this.default_secondary_connection_string
  sensitive   = true
  description = "The Secondary Connection String for the Service Bus Namespace."
}

output "primary_key" {
  value       = azurerm_servicebus_namespace.this.default_primary_key
  sensitive   = true
  description = "The Primary Key for the Service Bus Namespace."
}

output "secondary_key" {
  value       = azurerm_servicebus_namespace.this.default_secondary_key
  sensitive   = true
  description = "The Secondary Key for the Service Bus Namespace."
}

output "identity_principal_id" {
  value       = try(azurerm_servicebus_namespace.this.identity[0].principal_id, null)
  description = "The Principal ID of the Managed Identity assigned to Service Bus."
}

output "queues" {
  value       = { for k, v in azurerm_servicebus_queue.this : k => v.id }
  description = "Map of created Queue names to their IDs."
}

output "topics" {
  value       = { for k, v in azurerm_servicebus_topic.this : k => v.id }
  description = "Map of created Topic names to their IDs."
}

output "subscriptions" {
  value       = { for k, v in azurerm_servicebus_subscription.this : k => v.id }
  description = "Map of composite topic:subscription keys to their Resource IDs."
}
