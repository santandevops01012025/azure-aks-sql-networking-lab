output "vnet_id" {
  value       = module.vnet.id
  description = "Virtual Network Resource ID."
}

output "subnet_ids" {
  value = {
    "AzureBastionSubnet" = module.subnet_bastion.id
    "snet-aks"           = module.subnet_aks.id
    "snet-backend"       = module.subnet_backend.id
    "snet-pe"            = module.subnet_pe.id
    "snet-appservice"    = module.subnet_appservice.id
  }
  description = "Map of created Subnet IDs."
}

output "aks_cluster_name" {
  value       = module.aks.name
  description = "AKS Cluster Name."
}

output "aks_cluster_id" {
  value       = module.aks.id
  description = "AKS Cluster Resource ID."
}

output "acr_login_server" {
  value       = module.acr.login_server
  description = "Azure Container Registry Login Server."
}

output "key_vault_uri" {
  value       = module.key_vault.vault_uri
  description = "Key Vault Vault URI."
}

output "sql_server_fqdn" {
  value       = module.sql_server.fully_qualified_domain_name
  description = "SQL Server Fully Qualified Domain Name."
}

output "storage_account_name" {
  value       = module.storage.name
  description = "Primary Storage Account Name."
}

output "bastion_dns_name" {
  value       = module.bastion.dns_name
  description = "Azure Bastion Host FQDN."
}

output "nat_gateway_id" {
  value       = module.nat_gateway.id
  description = "NAT Gateway Resource ID."
}

output "redis_hostname" {
  value       = module.redis.hostname
  description = "Redis Cache Hostname."
}

output "web_app_urls" {
  value       = module.app_service.linux_web_apps
  description = "Linux Web Apps deployment outputs."
}
