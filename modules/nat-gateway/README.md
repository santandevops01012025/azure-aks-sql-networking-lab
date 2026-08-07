# Module 21: Azure NAT Gateway (`modules/nat-gateway`)

Enterprise-grade Azure NAT Gateway Terraform module providing scalable outbound internet connectivity for subnets inside Virtual Networks without exposing inbound traffic. Engineered for AzureRM Provider 4.x and Terraform >= 1.8.

---

## 1. Folder Structure

```
terraform-enterprise/
└── modules/
    └── nat-gateway/
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
| `azurerm_nat_gateway` | `this` | Primary Azure NAT Gateway resource |
| `azurerm_nat_gateway_public_ip_association` | `this` | Association between NAT Gateway and Standard Public IPs |
| `azurerm_nat_gateway_public_ip_prefix_association` | `this` | Association between NAT Gateway and Public IP Prefixes |
| `azurerm_subnet_nat_gateway_association` | `this` | Association between NAT Gateway and VNet Subnets |

---

## 3. Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Name of the Azure NAT Gateway (CAF `ng-` prefix). | `string` | n/a | yes |
| `resource_group_name` | Name of the Resource Group. | `string` | n/a | yes |
| `location` | Azure Region. | `string` | n/a | yes |
| `sku_name` | NAT Gateway SKU (`Standard`). | `string` | `"Standard"` | no |
| `idle_timeout_in_minutes` | Connection idle timeout in minutes (4-120). | `number` | `4` | no |
| `zones` | List of Availability Zones (e.g. `["1"]`). | `list(string)` | `null` | no |
| `public_ip_address_ids` | List of Public IP Resource IDs to attach. | `list(string)` | `[]` | no |
| `public_ip_prefix_ids` | List of Public IP Prefix Resource IDs to attach. | `list(string)` | `[]` | no |
| `subnet_ids` | List of Subnet IDs to attach to this NAT Gateway. | `list(string)` | `[]` | no |
| `tags` | Map of tags to assign to the NAT Gateway. | `map(string)` | `{}` | no |

---

## 4. Outputs

| Name | Description |
|------|-------------|
| `id` | The Resource ID of the Azure NAT Gateway. |
| `name` | The Name of the Azure NAT Gateway. |
| `resource_guid` | The Resource GUID of the Azure NAT Gateway. |

---

## 5. Parent Module Usage Example

```hcl
# Standard Public IP for NAT Gateway
module "pip_nat" {
  source              = "./modules/public-ip"
  name                = "pip-ng-dev-eastus"
  resource_group_name = module.rg_network.name
  location            = module.rg_network.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure NAT Gateway
module "nat_gateway" {
  source                = "./modules/nat-gateway"
  name                  = "ng-dev-eastus"
  resource_group_name   = module.rg_network.name
  location              = module.rg_network.location
  public_ip_address_ids = [module.pip_nat.id]
  subnet_ids            = [module.subnet_aks.id, module.subnet_backend.id]

  tags = {
    Environment = "dev"
    Component   = "OutboundNetwork"
  }
}
```

---

## 6. Explanation of Every Resource

1. **`azurerm_nat_gateway.this`**:
   - Provisioned Standard NAT Gateway providing dynamic SNAT for outbound internet access across all attached subnets.
2. **`azurerm_nat_gateway_public_ip_association.this`**:
   - Binds target static public IP addresses to supply dedicated outbound IP capacity.
3. **`azurerm_subnet_nat_gateway_association.this`**:
   - Routes outbound traffic from private workloads (e.g. AKS worker nodes, backend VMs) through the NAT Gateway.
