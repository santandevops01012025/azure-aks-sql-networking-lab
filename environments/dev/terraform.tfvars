environment        = "dev"
location           = "eastus"
workload           = "enterprise"
vnet_address_space = ["10.10.0.0/16"]
aks_node_count     = 2
aks_vm_size        = "Standard_D2s_v7"
sql_admin_username = "sqladmin"
sql_admin_password = "P@ssw0rdDev2026!Enterprise"

vm_name             = "vm-backend-dev-01"
vm_size             = "Standard_D2s_v7"
vm_zone             = null
vm_create_public_ip = true
vm_admin_username   = "azureuser"
vm_admin_password   = "Vm@dmin2026!"

tags = {
  Environment = "dev"
  Owner       = "DevOps-Team"
  ManagedBy   = "Terraform"
  Project     = "Enterprise-Platform"
}
