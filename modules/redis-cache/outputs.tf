output "id" {
  value       = azurerm_redis_cache.this.id
  description = "The Resource ID of the Azure Cache for Redis."
}

output "name" {
  value       = azurerm_redis_cache.this.name
  description = "The Name of the Azure Cache for Redis."
}

output "hostname" {
  value       = azurerm_redis_cache.this.hostname
  description = "The Hostname of the Azure Cache for Redis."
}

output "ssl_port" {
  value       = azurerm_redis_cache.this.ssl_port
  description = "The SSL Port of the Azure Cache for Redis."
}

output "port" {
  value       = azurerm_redis_cache.this.port
  description = "The Non-SSL Port of the Azure Cache for Redis."
}

output "primary_access_key" {
  value       = azurerm_redis_cache.this.primary_access_key
  sensitive   = true
  description = "The Primary Access Key for the Azure Cache for Redis."
}

output "secondary_access_key" {
  value       = azurerm_redis_cache.this.secondary_access_key
  sensitive   = true
  description = "The Secondary Access Key for the Azure Cache for Redis."
}

output "primary_connection_string" {
  value       = azurerm_redis_cache.this.primary_connection_string
  sensitive   = true
  description = "The Primary Connection String for the Azure Cache for Redis."
}

output "secondary_connection_string" {
  value       = azurerm_redis_cache.this.secondary_connection_string
  sensitive   = true
  description = "The Secondary Connection String for the Azure Cache for Redis."
}

output "identity_principal_id" {
  value       = try(azurerm_redis_cache.this.identity[0].principal_id, null)
  description = "The Principal ID of the Managed Service Identity assigned to Redis Cache."
}
