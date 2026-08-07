# Azure Network Security Group Association Terraform Module

Enterprise-grade Terraform module to associate Network Security Groups (NSG) with either Subnets or Network Interfaces (NICs).

## Features

- **Dual Mode**: Dynamically binds NSGs to Subnets (`subnet_id`) or Network Interfaces (`network_interface_id`).
- **Decoupled Architecture**: Prevents dependency deadlocks and direct resource entanglement in parent module scripts.
- **AzureRM 4.x & Terraform 1.8+**: Modern conditional count evaluation.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network_security_group_id | ID of the NSG to associate. | `string` | n/a | yes |
| subnet_id | Target Subnet ID. | `string` | `null` | no |
| network_interface_id | Target NIC ID. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| subnet_association_id | ID of the Subnet NSG Association (if applicable). |
| nic_association_id | ID of the NIC NSG Association (if applicable). |
