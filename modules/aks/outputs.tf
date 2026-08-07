output "id" {
  value       = azurerm_kubernetes_cluster.this.id
  description = "The ID of the Azure Kubernetes Service cluster."
}

output "name" {
  value       = azurerm_kubernetes_cluster.this.name
  description = "The Name of the Azure Kubernetes Service cluster."
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
  description = "The OIDC issuer URL for Workload Identity integration."
}

output "principal_id" {
  value       = var.identity_type == "SystemAssigned" ? azurerm_kubernetes_cluster.this.identity[0].principal_id : null
  description = "The Principal ID of the System-Assigned Managed Identity."
}

output "kubelet_identity" {
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
  description = "The Kubelet Identity details of the AKS cluster."
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
  description = "Raw Kubernetes config text for cluster connection."
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
  description = "Structured Kubernetes credentials block."
}
