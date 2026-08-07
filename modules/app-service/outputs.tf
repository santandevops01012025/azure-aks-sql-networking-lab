output "plan_id" {
  value       = azurerm_service_plan.this.id
  description = "The Resource ID of the App Service Plan."
}

output "plan_name" {
  value       = azurerm_service_plan.this.name
  description = "The Name of the App Service Plan."
}

output "linux_web_apps" {
  value = {
    for k, v in azurerm_linux_web_app.this : k => {
      id                    = v.id
      default_hostname      = v.default_hostname
      outbound_ip_addresses = v.outbound_ip_addresses
      identity_principal_id = try(v.identity[0].principal_id, null)
    }
  }
  description = "Map of created Linux Web Apps details."
}

output "windows_web_apps" {
  value = {
    for k, v in azurerm_windows_web_app.this : k => {
      id                    = v.id
      default_hostname      = v.default_hostname
      outbound_ip_addresses = v.outbound_ip_addresses
      identity_principal_id = try(v.identity[0].principal_id, null)
    }
  }
  description = "Map of created Windows Web Apps details."
}
