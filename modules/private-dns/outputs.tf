output "id" {
  value       = azurerm_private_dns_zone.this.id
  description = "The Resource ID of the Private DNS Zone."
}

output "name" {
  value       = azurerm_private_dns_zone.this.name
  description = "The Name of the Private DNS Zone."
}

output "number_of_record_sets" {
  value       = azurerm_private_dns_zone.this.number_of_record_sets
  description = "The current number of record sets in this Private DNS Zone."
}
