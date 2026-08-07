# Azure Application Gateway Standard_v2 Terraform Module

Enterprise-grade Terraform module to deploy Azure Application Gateway (`azurerm_application_gateway`) Standard_v2 or WAF_v2 with dynamic support for autoscale capacity, Key Vault SSL certificate retrieval via User Assigned Managed Identity, HTTP/HTTPS listeners, and custom health probes.

## Features

- **CAF Naming Standards**: Regex enforcement on `agw-*` or `appgw-*` naming convention.
- **Autoscale Capability**: Supports fixed capacity or dynamic `autoscale_configuration` (min/max instances).
- **Key Vault SSL Offloading**: Dynamic integration for Key Vault certificate references using User-Assigned Managed Identity.
- **Dynamic Configuration**: Fully decoupled dynamic blocks for frontend ports, listeners, rules, health probes, and backend settings.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using modern HCL constructs.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | App Gateway name (`agw-*` / `appgw-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| subnet_id | Dedicated Application Gateway Subnet ID. | `string` | n/a | yes |
| public_ip_id | Standard Public IP Resource ID. | `string` | n/a | yes |
| backend_address_pools | Backend target pools. | `list(object)` | n/a | yes |
| backend_http_settings | Backend HTTP settings configurations. | `list(object)` | n/a | yes |
| http_listeners | HTTP/HTTPS listener objects. | `list(object)` | n/a | yes |
| request_routing_rules | Routing rules mapping listeners to backends. | `list(object)` | n/a | yes |
| autoscale_configuration | Min/Max capacity autoscale object. | `object` | `null` | no |
| ssl_certificates | SSL Certificate reference objects. | `list(object)` | `[]` | no |
| probes | Custom health probes objects. | `list(object)` | `[]` | no |
| identity_ids | User Assigned Managed Identity IDs. | `list(string)` | `[]` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Application Gateway. |
| name | The Name of the Application Gateway. |
| frontend_ip_configuration | Frontend IP configuration block. |
| backend_address_pool | Backend address pool object details. |
