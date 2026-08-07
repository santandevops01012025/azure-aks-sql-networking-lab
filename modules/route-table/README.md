# Azure Route Table Terraform Module

Enterprise-grade Terraform module to deploy Azure Route Tables (`azurerm_route_table`) with User Defined Routes (UDR) for forcing traffic through Azure Firewalls, Network Virtual Appliances (NVAs), or ExpressRoute gateways.

## Features

- **CAF Naming Standards**: Regex validation on `rt-*` naming convention.
- **Dynamic Route Blocks**: Dynamic creation of routes with next-hop targets (`VirtualAppliance`, `Internet`, `None`, etc.).
- **Subnet Association**: Automated subnet association using `azurerm_subnet_route_table_association`.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using `bgp_route_propagation_enabled`.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Route Table name (`rt-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| bgp_route_propagation_enabled | Enable BGP propagation. | `bool` | `true` | no |
| routes | List of route object specifications. | `list(object)` | `[]` | no |
| subnet_ids | List of Subnet IDs to associate. | `list(string)` | `[]` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the Route Table. |
| name | The Name of the Route Table. |
| subnets | Set of associated subnet IDs. |
