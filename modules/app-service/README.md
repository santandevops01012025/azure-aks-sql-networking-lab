# Module 25: Azure App Service & Plan (`modules/app-service`)

Enterprise-grade Azure App Service & Plan Terraform module deploying Linux and Windows Web Apps with HTTPS enforcement, VNet integration, FTPS disablement, TLS 1.2 minimum encryption, HTTP/2, and Managed Identities. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── app-service/
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
| `azurerm_service_plan` | `this` | Primary Azure App Service Plan (Linux/Windows) |
| `azurerm_linux_web_app` | `this` | Dynamic map of Linux Web Apps |
| `azurerm_windows_web_app` | `this` | Dynamic map of Windows Web Apps |

---

## 3. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `plan_name` | Name of the App Service Plan (CAF `asp-` prefix, max 40 chars). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `os_type` | OS Type (`Linux`, `Windows`). | `string` | `"Linux"` | no |
| `sku_name` | Plan SKU (`B1`, `S1`, `P1v2`, `P1v3`, `P2v3`, `P3v3`). | `string` | `"P1v3"` | no |
| `worker_count` | Number of worker instances. | `number` | `1` | no |
| `zone_balancing_enabled` | Enable zone redundancy across AZs. | `bool` | `false` | no |
| `web_apps` | Map of Web Apps to instantiate under this plan. | `map(object)` | `{}` | no |
| `tags` | Map of tags to assign to resources. | `map(string)` | `{}` | no |

---

## 4. Outputs

| Name | Description |
|------|-------------|
| `plan_id` | Resource ID of the App Service Plan. |
| `plan_name` | Name of the App Service Plan. |
| `linux_web_apps` | Map of Linux Web Apps details (`id`, `default_hostname`, `outbound_ip_addresses`, `identity_principal_id`). |
| `windows_web_apps` | Map of Windows Web Apps details (`id`, `default_hostname`, `outbound_ip_addresses`, `identity_principal_id`). |

---

## 5. Parent Module Usage Example

```hcl
module "app_service" {
  source              = "./modules/app-service"
  plan_name           = "asp-web-dev-eastus"
  resource_group_name = module.rg_app.name
  location            = module.rg_app.location
  os_type             = "Linux"
  sku_name            = "P1v3"
  worker_count        = 2

  web_apps = {
    "app-frontend-dev" = {
      https_only                    = true
      public_network_access_enabled = false
      virtual_network_subnet_id     = module.subnet_appservice.id

      identity = {
        type = "SystemAssigned"
      }

      app_settings = {
        "NODE_ENV" = "production"
      }

      site_config = {
        always_on           = true
        ftps_state          = "Disabled"
        http2_enabled       = true
        minimum_tls_version = "1.2"
        application_stack = {
          node_version = "20-lts"
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Component   = "Frontend"
  }
}
```

---

## 6. Explanation of Every Resource

1. **`azurerm_service_plan.this`**:
   - Manages the compute worker pool for hosting web applications.
2. **`azurerm_linux_web_app.this` / `azurerm_windows_web_app.this`**:
   - Deploys web applications with HTTPS-only enforcement, VNet integration for private outbound networking, FTPS disabled, TLS 1.2 minimum security, and Managed Identity support.
