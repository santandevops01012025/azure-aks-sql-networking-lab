# Azure SQL Server Terraform Module

Enterprise-grade Terraform module to deploy Azure SQL Logical Server (`azurerm_mssql_server`) with optional Microsoft Entra ID (Azure AD) administrator integration, custom firewall rules, and enterprise-hardened private network controls.

## Features

- **CAF Naming Standards**: Regex enforcement on `sql-*` naming prefix.
- **Entra ID Authentication**: Dynamic block supporting Azure AD administrator assignment.
- **Security Hardening**: TLS 1.2 minimum enforcement and configurable public network access (disabled by default for private endpoints).
- **Firewall Controls**: Support for explicit IP ranges or Azure Internal Services access rules.
- **AzureRM 4.x & Terraform 1.8+**: Built using modern `azurerm_mssql_server` resource syntax.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | SQL Server name (`sql-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| administrator_login_password | Administrator password. | `string` | n/a | yes |
| administrator_login | Administrator username. | `string` | `"sqladmin"` | no |
| public_network_access_enabled | Public IP access boolean. | `bool` | `false` | no |
| minimum_tls_version | Minimum TLS version. | `string` | `"1.2"` | no |
| azuread_administrator | Entra ID administrator object. | `object` | `null` | no |
| firewall_rules | Map of IP rules to add. | `map(object)` | `{}` | no |
| allow_azure_services | Allow Azure Services rule (0.0.0.0). | `bool` | `false` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the SQL Server. |
| name | The Name of the SQL Server. |
| fully_qualified_domain_name | FQDN (e.g. sql-dev-eastus.database.windows.net). |
| administrator_login | The SQL Admin username. |
