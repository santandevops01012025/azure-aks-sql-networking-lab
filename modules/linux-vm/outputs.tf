output "id" {
  value       = azurerm_linux_virtual_machine.this.id
  description = "The ID of the Linux Virtual Machine."
}

output "name" {
  value       = azurerm_linux_virtual_machine.this.name
  description = "The Name of the Linux Virtual Machine."
}

output "nic_id" {
  value       = azurerm_network_interface.this.id
  description = "The ID of the Primary Network Interface created for the VM."
}

output "private_ip" {
  value       = azurerm_network_interface.this.private_ip_address
  description = "The Private IP Address assigned to the Virtual Machine."
}

output "public_ip" {
  value       = var.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
  description = "The Public IP Address assigned to the VM, if create_public_ip is true."
}

output "public_ip_id" {
  value       = var.create_public_ip ? azurerm_public_ip.this[0].id : null
  description = "The Resource ID of the Public IP assigned to the VM, if created."
}
