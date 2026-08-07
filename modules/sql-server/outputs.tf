output "id" {
  value       = azurerm_mssql_server.this.id
  description = "The ID of the Azure SQL Server."
}

output "name" {
  value       = azurerm_mssql_server.this.name
  description = "The Name of the Azure SQL Server."
}

output "fully_qualified_domain_name" {
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
  description = "The Fully Qualified Domain Name (FQDN) of the Azure SQL Server."
}

output "administrator_login" {
  value       = azurerm_mssql_server.this.administrator_login
  description = "The Administrator Login username for the Azure SQL Server."
}
