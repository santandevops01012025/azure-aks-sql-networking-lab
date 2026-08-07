environment        = "dev"
location           = "eastus"
workload           = "enterprise"
vnet_address_space = ["10.10.0.0/16"]
aks_node_count     = 2
aks_vm_size        = "Standard_D2s_v5"
sql_admin_username = "sqladmin"
sql_admin_password = "P@ssw0rdDev2026!Enterprise"

tags = {
  Environment = "dev"
  Owner       = "DevOps-Team"
  ManagedBy   = "Terraform"
  Project     = "Enterprise-Platform"
}
