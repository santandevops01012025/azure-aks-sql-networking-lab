output "id" {
  value       = azurerm_key_vault.this.id
  description = "The Resource ID of the Key Vault."
}

output "name" {
  value       = azurerm_key_vault.this.name
  description = "The Name of the Key Vault."
}

output "vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Vault for performing operations on keys and secrets."
}
