output "id" {
  value       = azurerm_storage_account.this.id
  description = "The Resource ID of the Storage Account."
}

output "name" {
  value       = azurerm_storage_account.this.name
  description = "The Name of the Storage Account."
}

output "primary_location" {
  value       = azurerm_storage_account.this.primary_location
  description = "The primary location of the storage account."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.this.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_file_endpoint" {
  value       = azurerm_storage_account.this.primary_file_endpoint
  description = "The endpoint URL for file storage in the primary location."
}

output "primary_queue_endpoint" {
  value       = azurerm_storage_account.this.primary_queue_endpoint
  description = "The endpoint URL for queue storage in the primary location."
}

output "primary_table_endpoint" {
  value       = azurerm_storage_account.this.primary_table_endpoint
  description = "The endpoint URL for table storage in the primary location."
}

output "primary_dfs_endpoint" {
  value       = azurerm_storage_account.this.primary_dfs_endpoint
  description = "The endpoint URL for Data Lake Storage Gen2 (DFS) in the primary location."
}

output "primary_access_key" {
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
  description = "The primary access key for the storage account."
}

output "secondary_access_key" {
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
  description = "The secondary access key for the storage account."
}

output "primary_connection_string" {
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
  description = "The connection string associated with the primary location."
}

output "secondary_connection_string" {
  value       = azurerm_storage_account.this.secondary_connection_string
  sensitive   = true
  description = "The connection string associated with the secondary location."
}

output "identity_principal_id" {
  value       = try(azurerm_storage_account.this.identity[0].principal_id, null)
  description = "The Principal ID of the Managed Service Identity assigned to this Storage Account."
}

output "identity_tenant_id" {
  value       = try(azurerm_storage_account.this.identity[0].tenant_id, null)
  description = "The Tenant ID of the Managed Service Identity assigned to this Storage Account."
}

output "containers" {
  value       = { for k, v in azurerm_storage_container.this : k => v.id }
  description = "Map of created container names to their resource IDs."
}

output "file_shares" {
  value       = { for k, v in azurerm_storage_share.this : k => v.id }
  description = "Map of created file share names to their resource IDs."
}

output "queues" {
  value       = { for k, v in azurerm_storage_queue.this : k => v.id }
  description = "Map of created queue names to their resource IDs."
}

output "tables" {
  value       = { for k, v in azurerm_storage_table.this : k => v.id }
  description = "Map of created table names to their resource IDs."
}
