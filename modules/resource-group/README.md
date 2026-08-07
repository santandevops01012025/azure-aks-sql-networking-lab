# Azure Resource Group Terraform Module

Enterprise-grade Terraform module to deploy and manage Azure Resource Groups with support for Microsoft Cloud Adoption Framework (CAF) naming standards, resource tagging, and optional Management Locks (`CanNotDelete` / `ReadOnly`).

## Features

- **CAF Compliance**: Regex validation enforcing `rg-*` naming convention.
- **Resource Locking**: Conditional deployment of `azurerm_management_lock` to protect core landing zone resource groups from accidental deletion.
- **Tagging Strategy**: Standardized resource metadata support.
- **AzureRM 4.x & Terraform 1.8+**: Built natively using modern Terraform patterns.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the Resource Group (must start with `rg-`). | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure Region location. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply. | `map(string)` | `{}` | no |
| <a name="input_managed_by"></a> [managed_by](#input\_managed_by) | ID of managing entity/resource. | `string` | `null` | no |
| <a name="input_lock_level"></a> [lock_level](#input\_lock_level) | Management lock level (`CanNotDelete` or `ReadOnly`). | `string` | `null` | no |
| <a name="input_lock_name"></a> [lock_name](#input\_lock_name) | Name of management lock override. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Resource Group. |
| <a name="output_location"></a> [location](#output\_location) | The Location of the Resource Group. |
| <a name="output_lock_id"></a> [lock_id](#output\_lock_id) | The ID of the Management Lock (if enabled). |
