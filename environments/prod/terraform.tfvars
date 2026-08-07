environment        = "prod"
location           = "eastus"
workload           = "enterprise"
vnet_address_space = ["10.30.0.0/16"]
aks_node_count     = 5
aks_vm_size        = "Standard_D8s_v5"
sql_admin_username = "sqladmin"
sql_admin_password = "P@ssw0rdProd2026!EnterpriseSecure"

tags = {
  Environment         = "prod"
  Owner               = "SRE-Ops"
  ManagedBy           = "Terraform"
  Project             = "Enterprise-Platform"
  BusinessCriticality = "High"
}
