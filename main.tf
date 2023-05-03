terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }

  # Update this block with the location of your terraform state file
  backend "azurerm" {
    resource_group_name  = "StorageAccount-RG"
    storage_account_name = "cuongnh34storageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "rg-aks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_resource_group" "rg-aks-2" {
  name     = "rg-terraform-github-actions-2"
  location = "eastus"
}

resource "azurerm_storage_account" "StorageAccount" {
  name                     = "cuongnh34storageaccount2"
  resource_group_name      = "StorageAccount-RG"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

resource "azurerm_storage_container" "cuongnh34" {
  name                  = "cuongnh34storage"
  container_access_type = "private"
  storage_account_name  = azurerm_storage_account.StorageAccount.name
}

resource "azurerm_storage_account" "StorageAccount3" {
  name                     = "cuongnh34storageaccount3"
  resource_group_name      = "StorageAccount-RG"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

resource "azurerm_storage_container" "cuongnh34-3" {
  name                  = "cuongnh34storage"
  container_access_type = "private"
  storage_account_name  = azurerm_storage_account.StorageAccount3.name
}
