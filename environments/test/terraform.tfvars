environment        = "test"
location           = "eastus2"
workload           = "enterprise"
vnet_address_space = ["10.20.0.0/16"]
aks_node_count     = 3
aks_vm_size        = "Standard_D4s_v5"
sql_admin_username = "sqladmin"
sql_admin_password = "P@ssw0rdTest2026!Enterprise"

tags = {
  Environment = "test"
  Owner       = "QA-Team"
  ManagedBy   = "Terraform"
  Project     = "Enterprise-Platform"
}
