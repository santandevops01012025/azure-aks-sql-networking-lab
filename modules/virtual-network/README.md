# Azure Virtual Network Terraform Module

Enterprise-grade Terraform module to deploy and manage Azure Virtual Networks (VNets) supporting Microsoft Cloud Adoption Framework (CAF) naming standards, custom DNS configurations, and DDoS protection plan integration.

## Features

- **CAF Compliance**: Regex validation enforcing `vnet-*` naming prefix.
- **Dynamic Configuration**: Supports custom DNS servers and dynamic DDoS protection plan attachment.
- **Modular Isolation**: Keeps Virtual Network definition decoupled from Subnet and NSG attachments for maximum reusability.
- **AzureRM 4.x & Terraform 1.8+**: Compatible with latest Terraform features and provider syntax.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the Virtual Network (must start with `vnet-`). | `string` | n/a | yes |
| resource_group_name | Name of the parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| address_space | List of CIDR address blocks for the VNet. | `list(string)` | n/a | yes |
| dns_servers | List of custom DNS IP addresses. | `list(string)` | `[]` | no |
| ddos_protection_plan | DDoS protection plan configuration block object. | `object` | `null` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Virtual Network. |
| name | The Name of the Virtual Network. |
| resource_group_name | The Resource Group Name of the Virtual Network. |
| location | The Azure Region location. |
| address_space | The address space of the Virtual Network. |
| guid | The GUID of the Virtual Network. |
