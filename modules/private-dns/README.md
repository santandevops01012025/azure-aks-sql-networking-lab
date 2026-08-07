# Azure Private DNS Zone Terraform Module

Enterprise-grade Terraform module to deploy Azure Private DNS Zones (`azurerm_private_dns_zone`) with automatic Virtual Network Links (`azurerm_private_dns_zone_virtual_network_link`) for Azure Private Endpoints.

## Features

- **Private Link Domain Standard**: Supports standard Azure Private Endpoint DNS domain names.
- **Dynamic VNet Link Attachment**: Automated linking to multiple VNets with optional auto-registration.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using `for_each` over link maps.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Private DNS Zone name. | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| vnet_links | Map of Virtual Network link configurations. | `map(object)` | `{}` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Private DNS Zone. |
| name | The Name of the Private DNS Zone. |
| number_of_record_sets | Count of record sets in the zone. |
