# 1. Resource Groups
module "rg_network" {
  source   = "../../modules/resource-group"
  name     = "rg-network-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}

module "rg_compute" {
  source   = "../../modules/resource-group"
  name     = "rg-compute-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}

module "rg_data" {
  source   = "../../modules/resource-group"
  name     = "rg-data-${var.environment}-${var.location}"
  location = var.location
  tags     = var.tags
}

# 2. Networking
module "vnet" {
  source              = "../../modules/virtual-network"
  name                = "vnet-${var.workload}-${var.environment}-${var.location}"
  resource_group_name = module.rg_network.name
  location            = module.rg_network.location
  address_space       = var.vnet_address_space
  tags                = var.tags
}

module "subnets" {
  source               = "../../modules/subnet"
  resource_group_name  = module.rg_network.name
  virtual_network_name = module.vnet.name

  subnets = {
    "AzureBastionSubnet" = {
      address_prefixes = ["10.20.0.0/26"]
    }
    "snet-aks" = {
      address_prefixes = ["10.20.4.0/22"]
    }
    "snet-backend" = {
      address_prefixes = ["10.20.8.0/24"]
    }
    "snet-pe" = {
      address_prefixes = ["10.20.9.0/24"]
    }
    "snet-appservice" = {
      address_prefixes = ["10.20.10.0/24"]
      delegations = [{
        name = "appservice-delegation"
        service_delegation = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }]
    }
  }
}

# 3. Log Analytics
module "log_analytics" {
  source              = "../../modules/log-analytics"
  name                = "log-${var.workload}-${var.environment}-${var.location}"
  resource_group_name = module.rg_compute.name
  location            = module.rg_compute.location
  retention_in_days   = 60
  tags                = var.tags
}

# 4. Azure Container Registry (ACR)
module "acr" {
  source              = "../../modules/acr"
  name                = "cr${var.workload}${var.environment}001"
  resource_group_name = module.rg_compute.name
  location            = module.rg_compute.location
  sku                 = "Standard"
  admin_enabled       = false
  tags                = var.tags
}

# 5. Azure Kubernetes Service (AKS)
module "aks" {
  source                     = "../../modules/aks"
  name                       = "aks-${var.workload}-${var.environment}-${var.location}"
  resource_group_name        = module.rg_compute.name
  location                   = module.rg_compute.location
  dns_prefix                 = "aks-${var.environment}"
  log_analytics_workspace_id = module.log_analytics.id
  vnet_subnet_id             = module.subnets.subnet_ids["snet-aks"]

  default_node_pool = {
    name       = "agentpool"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  tags = var.tags
}

# 6. Azure Key Vault
module "key_vault" {
  source                        = "../../modules/key-vault"
  name                          = "kv-${var.workload}-${var.environment}-001"
  resource_group_name           = module.rg_data.name
  location                      = module.rg_data.location
  tenant_id                     = "00000000-0000-0000-0000-000000000000"
  public_network_access_enabled = true
  tags                          = var.tags
}

# 7. Azure Storage Account
module "storage" {
  source                        = "../../modules/storage-account"
  name                          = "st${var.workload}${var.environment}001"
  resource_group_name           = module.rg_data.name
  location                      = module.rg_data.location
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  public_network_access_enabled = false

  containers = {
    "testdata" = {
      container_access_type = "private"
    }
  }

  tags = var.tags
}

# 8. Azure SQL Server & Database
module "sql_server" {
  source                       = "../../modules/sql-server"
  name                         = "sql-${var.workload}-${var.environment}-${var.location}"
  resource_group_name          = module.rg_data.name
  location                     = module.rg_data.location
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  tags                         = var.tags
}

module "sql_database" {
  source    = "../../modules/sql-database"
  name      = "sqldb-${var.workload}-${var.environment}"
  server_id = module.sql_server.id
  sku_name  = "GP_S_Gen5_2"
  tags      = var.tags
}

# 9. Bastion Host & Public IP
module "pip_bastion" {
  source              = "../../modules/public-ip"
  name                = "pip-bas-${var.environment}-${var.location}"
  resource_group_name = module.rg_network.name
  location            = module.rg_network.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "bastion" {
  source               = "../../modules/bastion"
  name                 = "bas-${var.environment}-${var.location}"
  resource_group_name  = module.rg_network.name
  location             = module.rg_network.location
  subnet_id            = module.subnets.subnet_ids["AzureBastionSubnet"]
  public_ip_address_id = module.pip_bastion.id
  sku                  = "Standard"
  scale_units          = 2
  tags                 = var.tags
}

# 10. NAT Gateway
module "pip_nat" {
  source              = "../../modules/public-ip"
  name                = "pip-ng-${var.environment}-${var.location}"
  resource_group_name = module.rg_network.name
  location            = module.rg_network.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "nat_gateway" {
  source                = "../../modules/nat-gateway"
  name                  = "ng-${var.environment}-${var.location}"
  resource_group_name   = module.rg_network.name
  location              = module.rg_network.location
  public_ip_address_ids = [module.pip_nat.id]
  subnet_ids            = [module.subnets.subnet_ids["snet-aks"], module.subnets.subnet_ids["snet-backend"]]
  tags                  = var.tags
}

# 11. Redis Cache
module "redis" {
  source                        = "../../modules/redis-cache"
  name                          = "redis-${var.workload}-${var.environment}"
  resource_group_name           = module.rg_data.name
  location                      = module.rg_data.location
  sku_name                      = "Standard"
  capacity                      = 2
  family                        = "C"
  public_network_access_enabled = false
  tags                          = var.tags
}

# 12. App Service & Plan
module "app_service" {
  source              = "../../modules/app-service"
  plan_name           = "asp-${var.workload}-${var.environment}"
  resource_group_name = module.rg_compute.name
  location            = module.rg_compute.location
  os_type             = "Linux"
  sku_name            = "P1v3"
  worker_count        = 2

  web_apps = {
    "app-${var.workload}-${var.environment}" = {
      https_only                = true
      virtual_network_subnet_id = module.subnets.subnet_ids["snet-appservice"]
      app_settings = {
        "ENV" = var.environment
      }
      site_config = {
        always_on = true
        application_stack = {
          node_version = "20-lts"
        }
      }
    }
  }

  tags = var.tags
}
