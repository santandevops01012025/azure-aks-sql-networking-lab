# Module 24: Azure Service Bus Messaging (`modules/service-bus`)

Enterprise-grade Azure Service Bus Terraform module supporting Queues, Topics, Subscriptions, Managed Identities, TLS 1.2 minimum encryption enforcement, and Private Endpoint readiness. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── service-bus/
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
| `azurerm_servicebus_namespace` | `this` | Primary Azure Service Bus Namespace |
| `azurerm_servicebus_queue` | `this` | Dynamic message queues |
| `azurerm_servicebus_topic` | `this` | Dynamic publish-subscribe topics |
| `azurerm_servicebus_subscription` | `this` | Dynamic subscriptions per topic |

---

## 3. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Service Bus Namespace (CAF `sb-` prefix, max 50 chars). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `sku` | Tier (`Basic`, `Standard`, `Premium`). | `string` | `"Standard"` | no |
| `capacity` | Messaging units for Premium SKU (`1`, `2`, `4`, `8`, `16`). | `number` | `0` | no |
| `public_network_access_enabled` | Allow public network access. | `bool` | `false` | no |
| `minimum_tls_version` | Minimum TLS version (`1.0`, `1.1`, `1.2`). | `string` | `"1.2"` | no |
| `identity` | Managed identity configuration. | `object` | `null` | no |
| `queues` | Map of queues with retention & dead-letter settings. | `map(object)` | `{}` | no |
| `topics` | Map of topics and nested subscriptions. | `map(object)` | `{}` | no |
| `tags` | Resource tags mapping. | `map(string)` | `{}` | no |

---

## 4. Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| `id` | Resource ID of the Service Bus Namespace. | no |
| `name` | Name of the Service Bus Namespace. | no |
| `endpoint` | Primary Endpoint URL. | no |
| `primary_connection_string` | Primary Connection String. | yes |
| `secondary_connection_string` | Secondary Connection String. | yes |
| `primary_key` | Primary Key. | yes |
| `secondary_key` | Secondary Key. | yes |
| `identity_principal_id` | Managed Identity Principal ID. | no |
| `queues` | Map of Queue names to IDs. | no |
| `topics` | Map of Topic names to IDs. | no |
| `subscriptions` | Map of `topic:subscription` keys to IDs. | no |

---

## 5. Parent Module Usage Example

```hcl
module "service_bus" {
  source                        = "./modules/service-bus"
  name                          = "sb-messaging-dev-eastus"
  resource_group_name           = module.rg_app.name
  location                      = module.rg_app.location
  sku                           = "Standard"
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  identity = {
    type = "SystemAssigned"
  }

  queues = {
    "orders-queue" = {
      enable_partitioning                  = false
      max_size_in_megabytes                = 1024
      requires_duplicate_detection         = true
      dead_lettering_on_message_expiration = true
      max_delivery_count                   = 10
    }
  }

  topics = {
    "events-topic" = {
      enable_partitioning          = false
      requires_duplicate_detection = true
      subscriptions = {
        "email-service-sub" = {
          max_delivery_count                   = 5
          dead_lettering_on_message_expiration = true
        }
        "audit-service-sub" = {
          max_delivery_count                   = 10
          dead_lettering_on_message_expiration = true
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Component   = "Messaging"
  }
}
```

---

## 6. Explanation of Every Resource

1. **`azurerm_servicebus_namespace.this`**:
   - Manages the Service Bus namespace with enterprise security defaults (Public network access disabled, TLS 1.2 minimum requirement).
2. **`azurerm_servicebus_queue.this`**:
   - Provisions point-to-point queues with configurable max size, dead-lettering, duplicate detection, and TTL.
3. **`azurerm_servicebus_topic.this` & `azurerm_servicebus_subscription.this`**:
   - Provisions pub/sub messaging channels with multi-consumer topic subscriptions.
