output "id" {
  value       = azurerm_route_table.this.id
  description = "The Resource ID of the Route Table."
}

output "name" {
  value       = azurerm_route_table.this.name
  description = "The Name of the Route Table."
}

output "subnets" {
  value       = azurerm_route_table.this.subnets
  description = "The collection of Subnet IDs associated with this Route Table."
}
