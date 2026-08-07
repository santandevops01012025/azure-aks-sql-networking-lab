output "subnet_association_id" {
  value       = length(azurerm_subnet_network_security_group_association.subnet) > 0 ? azurerm_subnet_network_security_group_association.subnet[0].id : null
  description = "The ID of the Subnet NSG Association, if created."
}

output "nic_association_id" {
  value       = length(azurerm_network_interface_security_group_association.nic) > 0 ? azurerm_network_interface_security_group_association.nic[0].id : null
  description = "The ID of the Network Interface NSG Association, if created."
}
