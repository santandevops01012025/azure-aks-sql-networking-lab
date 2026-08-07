# Azure SQL Database Terraform Module

Enterprise-grade Terraform module to provision Azure SQL Databases (`azurerm_mssql_database`) supporting Provisioned and Serverless compute tiers, Zone Redundancy, Read Scale-Out, and flexible Backup Storage Redundancy.

## Features

- **CAF Naming Standards**: Regex enforcement on `sqldb-*` naming prefix.
- **Compute Tier Flexibility**: Supports DTU (Basic, S0, P1) and vCore (General Purpose, Business Critical, Serverless) SKUs.
- **Zone Redundancy & Read Scale**: High availability configurations for mission-critical databases.
- **Backup Storage Redundancy**: Configurable backup redundancy (`Local`, `Zone`, `Geo`, `GeoZone`).
- **AzureRM 4.x & Terraform 1.8+**: Built natively using `azurerm_mssql_database`.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | SQL Database name (`sqldb-*`). | `string` | n/a | yes |
| server_id | Azure SQL Server Resource ID. | `string` | n/a | yes |
| sku_name | SKU Tier (`S0`, `GP_S_Gen5_2`, etc.). | `string` | `"S0"` | no |
| collation | Collation string. | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| max_size_gb | Max size in GB. | `number` | `32` | no |
| zone_redundant | Zone redundancy boolean. | `bool` | `false` | no |
| read_scale | Read replica scale out boolean. | `bool` | `false` | no |
| storage_account_type | Backup storage redundancy type. | `string` | `"Local"` | no |
| auto_pause_delay_in_minutes | Serverless auto-pause delay. | `number` | `null` | no |
| min_capacity | Serverless minimum vCores. | `number` | `null` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the SQL Database. |
| name | The Name of the SQL Database. |
