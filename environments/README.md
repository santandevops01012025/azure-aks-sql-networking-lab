# Enterprise Azure Environments Orchestration Layer

This directory contains the multi-environment orchestration layer for the Enterprise Azure Infrastructure Framework using Terraform and `.tfvars` configuration files.

---

## 1. Directory Structure

```
environments/
├── README.md
├── dev/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variables.tf
├── test/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── prod/
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── terraform.tfvars
    └── variables.tf
```

---

## 2. Environment Comparison Matrix

| Feature / Tier | **Development (`dev`)** | **Testing (`test`)** | **Production (`prod`)** |
|---|---|---|---|
| **Azure Region** | East US | East US 2 | East US |
| **VNet CIDR** | `10.10.0.0/16` | `10.20.0.0/16` | `10.30.0.0/16` |
| **AKS Cluster** | 2 Nodes (`Standard_D2s_v5`) | 3 Nodes (`Standard_D4s_v5`) | 5 Nodes (`Standard_D8s_v5`) |
| **Storage Account** | `Standard_LRS` | `Standard_ZRS` | `Standard_GZRS` (Blob Versioning Enabled) |
| **SQL Database** | `S0` Standard | `GP_S_Gen5_2` Serverless | `GP_Gen5_8` General Purpose |
| **Redis Cache** | `Standard` C1 | `Standard` C2 | `Premium` P1 (VNet Subnet Injected) |
| **App Service Plan**| `B1` (1 Worker) | `P1v3` (2 Workers) | `P2v3` (3 Workers + Zone Redundant) |
| **ACR SKU** | `Standard` | `Standard` | `Premium` |
| **Log Retention** | 30 Days | 60 Days | 365 Days |

---

## 3. How to Deploy an Environment

### Step 1: Navigate to the target environment directory
```bash
cd environments/dev
# or cd environments/test
# or cd environments/prod
```

### Step 2: Initialize Terraform
```bash
terraform init
```

### Step 3: Plan deployment using `.tfvars`
```bash
terraform plan -var-file="terraform.tfvars"
```

### Step 4: Apply deployment
```bash
terraform apply -var-file="terraform.tfvars" -auto-approve
```
