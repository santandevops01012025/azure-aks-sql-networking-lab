# Azure Subnet Terraform Module

Enterprise-grade Terraform module to deploy Azure Subnets supporting Service Endpoints, Private Endpoint Policies, and Service Delegations (e.g. for AKS, App Service, Databricks).

## Features

- **CAF Compliance**: Validates naming convention (`snet-*` or reserved Azure subnets).
- **Service Endpoints**: Configurable list of endpoints (e.g. `Microsoft.Storage`, `Microsoft.KeyVault`).
- **Subnet Delegation**: Dynamic support for delegated services.
- **Private Endpoint Policies**: Configurable network policy support (`Enabled`, `Disabled`, etc.).
- **AzureRM 4.x & Terraform 1.8+**: Modern HCL2 features.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Subnet name (`snet-*` or Azure reserved name). | `string` | n/a | yes |
| resource_group_name | Name of the parent Resource Group. | `string` | n/a | yes |
| virtual_network_name | Name of the target Virtual Network. | `string` | n/a | yes |
| address_prefixes | List of CIDR address blocks. | `list(string)` | n/a | yes |
| service_endpoints | Service endpoints to enable on subnet. | `list(string)` | `[]` | no |
| private_endpoint_network_policies | Private endpoint policy setting. | `string` | `"Disabled"` | no |
| delegation | Service delegation configuration object. | `object` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Subnet. |
| name | The Name of the Subnet. |
| address_prefixes | The CIDR prefixes of the Subnet. |
| virtual_network_name | The Name of the Virtual Network. |
| resource_group_name | The Name of the Resource Group. |
