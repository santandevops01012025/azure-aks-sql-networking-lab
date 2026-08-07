# Azure User Assigned Managed Identity Terraform Module

Enterprise-grade Terraform module to deploy Azure User Assigned Managed Identities (`azurerm_user_assigned_identity`) to facilitate passwordless RBAC authentication between Azure workloads (AKS, App Gateway, Key Vault, Storage, etc.).

## Features

- **CAF Naming Standards**: Regex enforcement on `id-*` / `mi-*` naming format.
- **Zero Credentials**: Eliminates hardcoded secrets and credentials across enterprise cloud infrastructure.
- **Full Identity Metadata**: Exposes `principal_id`, `client_id`, and `tenant_id` for RBAC role assignments and Key Vault access policies.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using modern HCL constructs.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Managed Identity name (`id-*` or `mi-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Managed Identity. |
| name | The Name of the Managed Identity. |
| principal_id | The Principal ID (Object ID) for RBAC role assignment. |
| client_id | The Client ID. |
| tenant_id | The Azure AD Tenant ID. |
