output "id" {
  value       = azurerm_bastion_host.this.id
  description = "The Resource ID of the Azure Bastion Host."
}

output "name" {
  value       = azurerm_bastion_host.this.name
  description = "The Name of the Azure Bastion Host."
}

output "dns_name" {
  value       = azurerm_bastion_host.this.dns_name
  description = "The FQDN of the Azure Bastion Host."
}

output "sku" {
  value       = azurerm_bastion_host.this.sku
  description = "The SKU of the Azure Bastion Host."
}
