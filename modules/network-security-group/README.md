# Azure Network Security Group Terraform Module

Enterprise-grade Terraform module to deploy Azure Network Security Groups (NSG) with inline dynamic security rules supporting individual or multiple port and CIDR ranges.

## Features

- **CAF Compliance**: Regex validation enforcing `nsg-*` naming format.
- **Dynamic Security Rules**: HCL object interface supporting optional single or array ranges for ports and source/destination IP prefixes.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using optional type object definitions.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | NSG name (`nsg-*`). | `string` | n/a | yes |
| resource_group_name | Name of the parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| rules | List of rule objects for inbound/outbound rules. | `list(object)` | `[]` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Network Security Group. |
| name | The Name of the Network Security Group. |
| resource_group_name | The Name of the Resource Group. |
| location | The Location of the Network Security Group. |
