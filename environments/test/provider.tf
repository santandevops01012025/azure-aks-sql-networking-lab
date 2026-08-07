terraform {
  required_version = ">= 1.8.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend configuration for Remote State Management
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate-test-eastus2"
  #   storage_account_name = "sttfstatetesteastus2001"
  #   container_name       = "tfstate"
  #   key                  = "test.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
