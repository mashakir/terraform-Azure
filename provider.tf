terraform {
  required_version = ">= 1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.2.0" # Use latest stable 3.x provider
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0" # Use latest stable 3.x provider
    }
  }

  # Terraform Cloud / Enterprise workspace configuration
  cloud {
    organization = "NimbleDevOps"

    workspaces {
      name = "Terraform"
    }
  }
}

# Configure the AzureRM Provider
provider "azurerm" {
  features {
    # Prevent accidental deletion of resource groups containing resources
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

    # Optional: enable all advanced features
    key_vault {
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Random provider (no special configuration required)
provider "random" {}
