# Azure Container Registry (ACR) Terraform Module

Enterprise-grade Terraform module to deploy Azure Container Registry (`azurerm_container_registry`) with support for Premium SKUs, Geo-Replication, Zone Redundancy, Private Networking, and Admin Account security disabling.

## Features

- **CAF Naming Standards**: Regex enforcement on `cr*` alphanumeric naming rules (Azure required format).
- **Security Hardening**: Admin account disabled by default (enforces RBAC/Managed Identity authentication via `AcrPull`/`AcrPush`).
- **Geo-Replication & High Availability**: Multi-region replication block and Zone Redundancy for Premium tier deployments.
- **Private Access**: Configurable public network access toggle for private endpoint integration.
- **AzureRM 4.x & Terraform 1.8+**: Built using native HCL2 constructs.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | ACR name (`cr*`, alphanumeric). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| sku | SKU Tier (`Basic`, `Standard`, `Premium`). | `string` | `"Premium"` | no |
| admin_enabled | Enable admin username/password. | `bool` | `false` | no |
| public_network_access_enabled | Enable public internet access. | `bool` | `false` | no |
| zone_redundancy_enabled | Enable Availability Zone redundancy. | `bool` | `true` | no |
| georeplications | List of regional replication targets. | `list(object)` | `[]` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Container Registry. |
| name | The Name of the Container Registry. |
| login_server | The FQDN login server (e.g. `crdeveastus.azurecr.io`). |
| admin_username | Admin username (sensitive, if enabled). |
| admin_password | Admin password (sensitive, if enabled). |
