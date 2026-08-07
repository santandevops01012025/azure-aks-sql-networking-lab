# Module 22: Azure Cache for Redis (`modules/redis-cache`)

Enterprise-grade Azure Cache for Redis Terraform module providing secure, in-memory caching with TLS 1.2 enforcement, disabled non-SSL ports, private network isolation, and patch scheduling. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── redis-cache/
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
| `azurerm_redis_cache` | `this` | Primary Azure Cache for Redis instance |

---

## 3. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Redis Cache (CAF `redis-` prefix, max 63 chars). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `sku_name` | SKU of the Redis Cache (`Basic`, `Standard`, `Premium`). | `string` | `"Standard"` | no |
| `capacity` | SKU capacity size (0-6 for Basic/Standard, 1-5 for Premium). | `number` | `1` | no |
| `family` | SKU family (`C` for Basic/Standard, `P` for Premium). | `string` | `"C"` | no |
| `non_ssl_port_enabled` | Enable non-SSL port (6379). | `bool` | `false` | no |
| `minimum_tls_version` | Enforce minimum TLS version (`1.0`, `1.1`, `1.2`). | `string` | `"1.2"` | no |
| `public_network_access_enabled` | Enable public network access. | `bool` | `false` | no |
| `subnet_id` | Subnet ID for VNet injection (Premium SKU only). | `string` | `null` | no |
| `private_static_ip_address` | Static IP in subnet (Premium SKU only). | `string` | `null` | no |
| `redis_configuration` | Memory policies and RDB/AOF persistence options. | `object` | `null` | no |
| `identity` | Managed identity configuration object. | `object` | `null` | no |
| `patch_schedule` | List of maintenance patch windows. | `list(object)` | `[]` | no |
| `tags` | Map of tags to assign to the Redis Cache. | `map(string)` | `{}` | no |

---

## 4. Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| `id` | The Resource ID of the Redis Cache. | no |
| `name` | The Name of the Redis Cache. | no |
| `hostname` | The Hostname of the Redis Cache. | no |
| `ssl_port` | The SSL Port of the Redis Cache (default 6380). | no |
| `port` | The Non-SSL Port of the Redis Cache. | no |
| `primary_access_key` | Primary access key. | yes |
| `secondary_access_key` | Secondary access key. | yes |
| `primary_connection_string` | Primary connection string. | yes |
| `secondary_connection_string` | Secondary connection string. | yes |
| `identity_principal_id` | Principal ID of assigned Managed Identity. | no |

---

## 5. Parent Module Usage Example

```hcl
module "redis" {
  source                        = "./modules/redis-cache"
  name                          = "redis-app-dev-eastus"
  resource_group_name           = module.rg_app.name
  location                      = module.rg_app.location
  sku_name                      = "Standard"
  capacity                      = 1
  family                        = "C"
  minimum_tls_version           = "1.2"
  non_ssl_port_enabled          = false
  public_network_access_enabled = false

  redis_configuration = {
    maxmemory_reserved = 50
    maxmemory_policy   = "volatile-lru"
  }

  patch_schedule = [
    {
      day_of_week    = "Sunday"
      start_hour_utc = 2
    }
  ]

  tags = {
    Environment = "dev"
    Component   = "Cache"
  }
}
```

---

## 6. Explanation of Every Resource

1. **`azurerm_redis_cache.this`**:
   - Provisioned with zero public network access, minimum TLS 1.2 enforcement, and disabled plain-text non-SSL port 6379 for zero-trust security compliance.
   - Supports memory eviction policies (`volatile-lru`, `allkeys-lru`) and scheduled patch maintenance windows.
