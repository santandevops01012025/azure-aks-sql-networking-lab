output "id" {
  value       = azurerm_public_ip.this.id
  description = "The Resource ID of the Public IP."
}

output "name" {
  value       = azurerm_public_ip.this.name
  description = "The Name of the Public IP."
}

output "ip_address" {
  value       = azurerm_public_ip.this.ip_address
  description = "The IP Address assigned to the Public IP resource."
}

output "fqdn" {
  value       = azurerm_public_ip.this.fqdn
  description = "The Fully Qualified Domain Name (FQDN) of the Public IP if domain_name_label was configured."
}
