# Module 20: Azure Bastion Host (`modules/bastion`)

Enterprise-grade Azure Bastion Host Terraform module providing secure, agentless RDP and SSH connectivity over TLS directly to Virtual Machines without exposing public IP addresses. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── bastion/
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
| `azurerm_bastion_host` | `this` | Primary Azure Bastion Host resource |

---

## 3. Subnet Requirement

> [!IMPORTANT]
> Azure Bastion **must** be deployed into a dedicated subnet named **`AzureBastionSubnet`**.
> The subnet mask must be **/26 or larger** (e.g., `/26`, `/25`, `/24`) to accommodate scale units and maintenance upgrades.

---

## 4. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Azure Bastion Host (CAF `bas-` prefix). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `subnet_id` | Resource ID of the `AzureBastionSubnet`. | `string` | n/a | yes |
| `public_ip_address_id` | Resource ID of the associated Standard Public IP. | `string` | `null` | no |
| `sku` | Bastion SKU (`Developer`, `Basic`, `Standard`, `Premium`). | `string` | `"Standard"` | no |
| `scale_units` | Number of scale instances (2 to 50 for Standard/Premium). | `number` | `2` | no |
| `copy_paste_enabled` | Enable copy/paste features in portal session. | `bool` | `true` | no |
| `file_copy_enabled` | Enable file uploading/downloading via web client. | `bool` | `true` | no |
| `ip_connect_enabled` | Allow direct IP connecting to target VMs. | `bool` | `false` | no |
| `shareable_link_enabled` | Enable shareable session links for external users. | `bool` | `false` | no |
| `tunneling_enabled` | Enable Native Client support (`az network bastion rdp/ssh`). | `bool` | `true` | no |
| `kerberos_enabled` | Enable Kerberos authentication support. | `bool` | `false` | no |
| `tags` | Map of tags to assign to the Bastion Host. | `map(string)` | `{}` | no |

---

## 5. Outputs

| Name | Description |
|------|-------------|
| `id` | The Resource ID of the Azure Bastion Host. |
| `name` | The Name of the Azure Bastion Host. |
| `dns_name` | The FQDN of the Azure Bastion Host. |
| `sku` | The SKU of the Azure Bastion Host. |

---

## 6. Parent Module Usage Example

```hcl
# Standard Public IP for Bastion
module "pip_bastion" {
  source              = "./modules/public-ip"
  name                = "pip-bas-dev-eastus"
  resource_group_name = module.rg.name
  location            = module.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Bastion Host
module "bastion" {
  source               = "./modules/bastion"
  name                 = "bas-dev-eastus"
  resource_group_name  = module.rg.name
  location             = module.rg.location
  subnet_id            = module.subnet_bastion.id # Subnet MUST be named AzureBastionSubnet
  public_ip_address_id = module.pip_bastion.id
  sku                  = "Standard"
  scale_units          = 2
  tunneling_enabled    = true
  file_copy_enabled     = true

  tags = {
    Environment = "dev"
    Component   = "Bastion"
  }
}
```

---

## 7. Explanation of Every Resource

1. **`azurerm_bastion_host.this`**:
   - Creates a managed Bastion PaaS instance attached to the dedicated `AzureBastionSubnet`.
   - Enables native client tunneling via Azure CLI (`az network bastion ssh / rdp`), enabling secure administration without exposing public IPs on virtual machine NICs.
