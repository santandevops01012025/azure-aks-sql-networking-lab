# Module 19: Azure Storage Account (`modules/storage-account`)

Enterprise-grade Azure Storage Account Terraform module supporting Blob, File, Queue, Table, Data Lake Storage Gen2 (HNS), managed identities, network ACLs, soft delete policies, and versioning. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── storage-account/
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
| `azurerm_storage_account` | `this` | Primary Azure Storage Account |
| `azurerm_storage_container` | `this` | Dynamic storage blob containers |
| `azurerm_storage_share` | `this` | Dynamic storage file shares |
| `azurerm_storage_queue` | `this` | Dynamic storage queues |
| `azurerm_storage_table` | `this` | Dynamic storage tables |

---

## 3. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Storage Account (CAF format `st...`, 3-24 chars, lowercase alphanumeric). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `account_tier` | Storage account tier (`Standard` or `Premium`). | `string` | `"Standard"` | no |
| `account_replication_type` | Data replication (`LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS`, `RAGZRS`). | `string` | `"ZRS"` | no |
| `account_kind` | Storage account kind (`StorageV2`, `BlobStorage`, `BlockBlobStorage`, etc.). | `string` | `"StorageV2"` | no |
| `access_tier` | Default blob access tier (`Hot` or `Cool`). | `string` | `"Hot"` | no |
| `min_tls_version` | Minimum TLS version enforced (`TLS1_2`). | `string` | `"TLS1_2"` | no |
| `shared_access_key_enabled` | Enable authorization via Shared Key. | `bool` | `true` | no |
| `public_network_access_enabled` | Enable public network access. | `bool` | `false` | no |
| `default_to_oauth_authentication` | Default Azure portal auth to Entra ID (OAuth). | `bool` | `true` | no |
| `is_hns_enabled` | Enable Hierarchical Namespace (ADLS Gen2). | `bool` | `false` | no |
| `nfsv3_enabled` | Enable NFSv3 protocol support. | `bool` | `false` | no |
| `large_file_shares_enabled` | Enable large file shares. | `bool` | `false` | no |
| `blob_properties` | Blob service settings (soft delete, retention, versioning). | `object` | `null` | no |
| `share_properties` | File share service settings (soft delete retention). | `object` | `null` | no |
| `network_rules` | Network firewall ACL rules. | `object` | `null` | no |
| `identity` | Managed identity configuration block. | `object` | `null` | no |
| `containers` | Map of blob containers to instantiate. | `map(object)` | `{}` | no |
| `file_shares` | Map of file shares to instantiate. | `map(object)` | `{}` | no |
| `queues` | List of queue names to instantiate. | `list(string)` | `[]` | no |
| `tables` | List of table names to instantiate. | `list(string)` | `[]` | no |
| `tags` | Resource tags mapping. | `map(string)` | `{}` | no |

---

## 4. Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| `id` | Resource ID of the Storage Account. | no |
| `name` | Name of the Storage Account. | no |
| `primary_location` | Primary location of the Storage Account. | no |
| `primary_blob_endpoint` | Primary Blob service endpoint URL. | no |
| `primary_file_endpoint` | Primary File service endpoint URL. | no |
| `primary_queue_endpoint` | Primary Queue service endpoint URL. | no |
| `primary_table_endpoint` | Primary Table service endpoint URL. | no |
| `primary_dfs_endpoint` | Primary ADLS Gen2 DFS service endpoint URL. | no |
| `primary_access_key` | Primary storage access key. | yes |
| `secondary_access_key` | Secondary storage access key. | yes |
| `primary_connection_string` | Primary storage connection string. | yes |
| `secondary_connection_string` | Secondary storage connection string. | yes |
| `identity_principal_id` | Managed Identity Principal ID. | no |
| `identity_tenant_id` | Managed Identity Tenant ID. | no |
| `containers` | Map of container names to IDs. | no |
| `file_shares` | Map of file share names to IDs. | no |
| `queues` | Map of queue names to IDs. | no |
| `tables` | Map of table names to IDs. | no |

---

## 5. Parent Module Usage Example

```hcl
module "storage_appdata" {
  source                        = "./modules/storage-account"
  name                          = "stappdatadev001"
  resource_group_name           = module.rg_app.name
  location                      = module.rg_app.location
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  public_network_access_enabled = false
  min_tls_version               = "TLS1_2"

  identity = {
    type = "SystemAssigned"
  }

  blob_properties = {
    versioning_enabled  = true
    change_feed_enabled = true
    delete_retention_policy = {
      days = 14
    }
    container_delete_retention_policy = {
      days = 14
    }
  }

  network_rules = {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = [module.subnet_backend.id]
  }

  containers = {
    "app-logs" = {
      container_access_type = "private"
    }
    "backups" = {
      container_access_type = "private"
    }
  }

  tags = {
    Environment = "dev"
    Workload    = "EnterpriseData"
  }
}
```

---

## 6. Explanation of Every Resource

1. **`azurerm_storage_account.this`**:
   - Provisioned with zero public access by default, forced TLS 1.2, ZRS redundant storage, and Entra ID portal authentication.
   - Configures blob & file retention, soft-delete, versioning, and network ACL restrictions.
2. **`azurerm_storage_container.this`**:
   - Instantiates blob storage containers securely with private access tiers.
3. **`azurerm_storage_share.this`**:
   - Instantiates SMB/NFS file shares with defined storage quotas.
4. **`azurerm_storage_queue.this`**:
   - Provisioned message queues for asynchronous workload processing.
5. **`azurerm_storage_table.this`**:
   - Provisioned NoSQL key-value table storage endpoints.
