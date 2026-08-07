# Azure Kubernetes Service (AKS) Terraform Module

Enterprise-grade Terraform module to deploy production-ready Azure Kubernetes Service (AKS) clusters with support for Azure CNI, Workload Identity (OIDC), Auto-scaling System Node Pools, Log Analytics Container Insights, and Managed Identities.

## Features

- **CAF Naming Standards**: Enforces `aks-*` naming convention.
- **Enterprise Networking**: Configurable Azure CNI / Kubenet plugin and network policy (Azure CNI / Calico / Cilium).
- **Auto-Scaling System Pool**: Multi-zone support across Availability Zones 1, 2, and 3.
- **Modern Security**: OIDC Issuer URL and Azure AD Workload Identity enabled by default.
- **Monitoring Integration**: OMS Agent integration for Azure Monitor / Container Insights.
- **AzureRM 4.x & Terraform 1.8+**: Compatible with provider 4.x.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| azurerm | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | AKS Cluster name (`aks-*`). | `string` | n/a | yes |
| resource_group_name | Name of parent Resource Group. | `string` | n/a | yes |
| location | Azure Region location. | `string` | n/a | yes |
| dns_prefix | DNS prefix for cluster FQDN. | `string` | n/a | yes |
| default_node_pool | Configuration object for default system node pool. | `object` | `{...}` | no |
| sku_tier | SLA Tier (`Free`, `Standard`, `Premium`). | `string` | `"Standard"` | no |
| identity_type | Managed Identity type. | `string` | `"SystemAssigned"` | no |
| network_plugin | CNI plugin (`azure`, `kubenet`). | `string` | `"azure"` | no |
| network_policy | Network policy engine (`azure`, `calico`). | `string` | `"azure"` | no |
| log_analytics_workspace_id | Log Analytics workspace ID for container insights. | `string` | `null` | no |
| tags | Map of metadata tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Resource ID of the AKS cluster. |
| name | The Name of the AKS cluster. |
| oidc_issuer_url | OIDC URL for Workload Identity. |
| principal_id | System Assigned Identity Principal ID. |
| kubelet_identity | Object containing Kubelet Client ID & Object ID. |
| kube_config_raw | Raw kubeconfig credentials text (sensitive). |
| kube_config | Structured kubeconfig block (sensitive). |
