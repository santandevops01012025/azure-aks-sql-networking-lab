# Azure Linux Virtual Machine Terraform Module

Enterprise-grade Terraform module to deploy Linux Virtual Machines (Ubuntu LTS) with SSH key authentication, optional Public IP, managed OS and data disks, availability zone support, and boot diagnostics.

## Features

- **CAF Naming Standards**: Regex enforcement on `vm-*` naming prefix.
- **Ubuntu LTS Default Image**: Uses free canonical Ubuntu 22.04 LTS server image.
- **SSH Key Authentication**: Password authentication disabled by default for hardened security posture.
- **Availability Zone Integration**: High availability zone deployment (`"1"`, `"2"`, or `"3"`).
- **Storage Subsystem**: Managed OS disk and dynamic attachment of optional managed data disks.
- **Boot Diagnostics**: Native Azure managed boot diagnostics integration.
- **AzureRM 4.x & Terraform 1.8+**: Compatible with provider 4.x syntax.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | VM name (`vm-*`). | `string` | n/a | yes |
| resource_group_name | Name of the parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| subnet_id | Target Subnet ID. | `string` | n/a | yes |
| ssh_public_key | OpenSSH Public Key content. | `string` | n/a | yes |
| vm_size | Azure VM SKU. | `string` | `"Standard_B2s"` | no |
| admin_username | Administrative username. | `string` | `"azureuser"` | no |
| create_public_ip | Create & attach dynamic Standard Public IP. | `bool` | `false` | no |
| zone | Availability Zone ID (`"1"`, `"2"`, `"3"`). | `string` | `"1"` | no |
| os_disk_type | OS Disk SKU (`Premium_LRS`, etc.). | `string` | `"Premium_LRS"` | no |
| os_disk_size_gb | OS Disk size in GB. | `number` | `30` | no |
| data_disks | List of optional data disk objects to create/attach. | `list(object)` | `[]` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Virtual Machine. |
| name | The Name of the Virtual Machine. |
| nic_id | The ID of the primary NIC. |
| private_ip | The Private IP Address of the VM. |
| public_ip | The Public IP Address (if enabled). |
| public_ip_id | The Public IP Resource ID (if enabled). |
