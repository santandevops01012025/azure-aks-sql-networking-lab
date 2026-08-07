output "environment_id" {
  value       = azurerm_container_app_environment.this.id
  description = "The Resource ID of the Container App Environment."
}

output "environment_name" {
  value       = azurerm_container_app_environment.this.name
  description = "The Name of the Container App Environment."
}

output "environment_default_domain" {
  value       = azurerm_container_app_environment.this.default_domain
  description = "The default domain suffix of the Container App Environment."
}

output "environment_static_ip_address" {
  value       = azurerm_container_app_environment.this.static_ip_address
  description = "The Static IP Address of the Container App Environment."
}

output "container_apps" {
  value = {
    for k, v in azurerm_container_app.this : k => {
      id                    = v.id
      fqdn                  = try(v.ingress[0].fqdn, null)
      outbound_ip_addresses = v.outbound_ip_addresses
      identity_principal_id = try(v.identity[0].principal_id, null)
    }
  }
  description = "Map of created Container App names to their details (id, fqdn, outbound IPs, principal ID)."
}
