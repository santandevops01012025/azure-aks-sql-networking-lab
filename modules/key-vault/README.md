# Azure Key Vault Terraform Module

Enterprise-grade Terraform module to deploy Azure Key Vault (`azurerm_key_vault`) with support for Entra ID RBAC Authorization, Purge Protection, Soft Delete, Network ACLs, and Private Endpoint readiness.

## Features

- **CAF Naming Standards**: Regex validation for `kv-*` prefix and global length limits (3-24 characters).
- **Security Hardening**: Defaults to Azure RBAC Authorization, Purge Protection enabled, and public network access disabled.
- **Access Policies vs. RBAC**: Supports both modern Entra ID RBAC roles and legacy Access Policy lists dynamically.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using modern provider specifications.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Key Vault name (`kv-*`, 3-24 chars). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| tenant_id | Entra ID Tenant GUID. | `string` | n/a | yes |
| sku_name | SKU Tier (`standard`, `premium`). | `string` | `"standard"` | no |
| enable_rbac_authorization | Use Entra RBAC for permissions. | `bool` | `true` | no |
| purge_protection_enabled | Enable Purge Protection. | `bool` | `true` | no |
| soft_delete_retention_days | Soft delete retention days (7-90). | `number` | `90` | no |
| public_network_access_enabled | Enable public access. | `bool` | `false` | no |
| network_acls | Network ACL configuration object. | `object` | `null` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Key Vault. |
| name | The Name of the Key Vault. |
| vault_uri | The URI of the Key Vault. |
