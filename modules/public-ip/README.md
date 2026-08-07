# Azure Public IP Terraform Module

Enterprise-grade Terraform module to deploy standalone Azure Public IP addresses (`azurerm_public_ip`) with support for Standard SKU, Availability Zones, custom DNS domain labels, and DDoS Protection mode.

## Features

- **CAF Naming Standards**: Enforces `pip-*` naming convention.
- **Availability Zone Resilience**: Zone-redundant IP allocation across Availability Zones `["1", "2", "3"]`.
- **DNS FQDN Integration**: Optional `domain_name_label` for automatic Azure domain assignment.
- **AzureRM 4.x & Terraform 1.8+**: Compatible with provider 4.x parameters.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Public IP name (`pip-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| allocation_method | Allocation method (`Static`, `Dynamic`). | `string` | `"Static"` | no |
| sku | SKU Tier (`Basic`, `Standard`). | `string` | `"Standard"` | no |
| zones | Availability zones list. | `list(string)` | `["1","2","3"]` | no |
| domain_name_label | Optional DNS domain label prefix. | `string` | `null` | no |
| ddos_protection_mode | DDoS mode. | `string` | `"VirtualNetworkInherited"` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Public IP. |
| name | The Name of the Public IP. |
| ip_address | The allocated IP address string. |
| fqdn | The FQDN assigned to the Public IP (if domain label specified). |
