# Azure Log Analytics Workspace Terraform Module

Enterprise-grade Terraform module to deploy central Azure Log Analytics Workspaces (`azurerm_log_analytics_workspace`) for central diagnostic ingestion, SIEM integration, Sentinel, and Azure Container Insights.

## Features

- **CAF Naming Standards**: Enforces `log-*` naming convention.
- **Data Governance**: Configurable retention period (30 - 730 days) and optional daily ingestion quotas.
- **Perimeter Controls**: Configurable internet ingestion and query policies.
- **AzureRM 4.x & Terraform 1.8+**: Built natively for modern Terraform provider standards.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Log Analytics name (`log-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| sku | Workspace SKU. | `string` | `"PerGB2018"` | no |
| retention_in_days | Log retention days (30-730). | `number` | `30` | no |
| daily_quota_gb | Max daily volume cap in GB (-1 = unlimited). | `number` | `-1` | no |
| internet_ingestion_enabled | Enable internet ingestion. | `bool` | `true` | no |
| internet_query_enabled | Enable internet querying. | `bool` | `true` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Log Analytics Workspace. |
| name | The Name of the Log Analytics Workspace. |
| workspace_id | The Workspace GUID ID. |
| primary_shared_key | Primary Workspace shared key (sensitive). |
| secondary_shared_key | Secondary Workspace shared key (sensitive). |
