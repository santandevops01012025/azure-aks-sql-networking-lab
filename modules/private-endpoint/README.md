# Azure Private Endpoint Terraform Module

Enterprise-grade Terraform module to deploy Azure Private Endpoints (`azurerm_private_endpoint`) for PaaS resources (Key Vault, SQL Server, Storage Accounts, ACR, AKS) with integrated Private DNS Zone registration.

## Features

- **CAF Naming Standards**: Regex enforcement on `pe-*` naming prefix.
- **PaaS Isolation**: Eliminates public IP accessibility for PaaS services by injecting them into private subnets.
- **Private DNS Zone Group Integration**: Automated DNS record registration into linked Private DNS Zones.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using provider 4.x specifications.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Private Endpoint name (`pe-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| subnet_id | Target Subnet ID. | `string` | n/a | yes |
| private_connection_resource_id | Target PaaS Resource ID. | `string` | n/a | yes |
| subresource_names | Target subresource list (`vault`, `sqlServer`, etc.). | `list(string)` | n/a | yes |
| is_manual_connection | Require manual approval. | `bool` | `false` | no |
| private_dns_zone_group | Private DNS Zone group registration object. | `object` | `null` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Private Endpoint. |
| name | The Name of the Private Endpoint. |
| private_ip_address | The Allocated Private IP Address string. |
| private_service_connection | Private service connection details. |
