# Module 23: Azure Container App Environment & Apps (`modules/container-app`)

Enterprise-grade Azure Container Apps Terraform module deploying serverless microservices with Kubernetes & Envoy backing, automatic autoscaling (HTTP/CPU/Memory), Log Analytics integration, Managed Identities, and secret store integration. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── container-app/
        ├── README.md
        ├── main.tf
        ├── outputs.tf
        ├── variables.tf
        └── versions.tf
```

---

## 2. Resources Managed

| Resource Type | Resource Name | Description |
|---|---|---|
| `azurerm_container_app_environment` | `this` | Managed Serverless Container App Environment |
| `azurerm_container_app` | `this` | Dynamic map of microservice Container Apps |

---

## 3. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `environment_name` | Name of the Container App Environment (CAF `cae-` prefix). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `log_analytics_workspace_id` | Log Analytics workspace resource ID. | `string` | `null` | no |
| `infrastructure_subnet_id` | Subnet ID for VNet integration. | `string` | `null` | no |
| `internal_load_balancer_enabled` | Enable internal load balancer mode. | `bool` | `false` | no |
| `container_apps` | Map of Container Apps to instantiate. | `map(object)` | `{}` | no |
| `tags` | Map of tags to assign to resources. | `map(string)` | `{}` | no |

---

## 4. Outputs

| Name | Description |
|------|-------------|
| `environment_id` | Resource ID of the Container App Environment. |
| `environment_name` | Name of the Container App Environment. |
| `environment_default_domain` | Default FQDN domain suffix of the environment. |
| `environment_static_ip_address` | Static IP Address of the environment. |
| `container_apps` | Map of container app names to object containing `id`, `fqdn`, `outbound_ip_addresses`, and `identity_principal_id`. |

---

## 5. Parent Module Usage Example

```hcl
module "container_apps" {
  source                     = "./modules/container-app"
  environment_name           = "cae-dev-eastus"
  resource_group_name        = module.rg_app.name
  location                   = module.rg_app.location
  log_analytics_workspace_id = module.log_analytics.id
  infrastructure_subnet_id   = module.subnet_containers.id

  container_apps = {
    "ca-api-dev" = {
      revision_mode = "Single"

      identity = {
        type = "SystemAssigned"
      }

      ingress = {
        external_enabled = true
        target_port      = 8080
        transport        = "auto"
      }

      containers = [
        {
          name   = "web-api"
          image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
          cpu    = 0.5
          memory = "1.0Gi"
          env = [
            {
              name  = "ENV"
              value = "development"
            }
          ]
        }
      ]

      min_replicas = 1
      max_replicas = 5

      http_scale_rules = [
        {
          name                = "http-requests-scaler"
          concurrent_requests = 100
        }
      ]
    }
  }

  tags = {
    Environment = "dev"
    Component   = "Microservices"
  }
}
```

---

## 6. Explanation of Every Resource

1. **`azurerm_container_app_environment.this`**:
   - Manages the underlying serverless environment, VNet integration, and Log Analytics diagnostic collection.
2. **`azurerm_container_app.this`**:
   - Deploys containerized microservices configured with dynamic ingress endpoints, HTTP scaling rules, registry credentials, and managed identity authorization.
