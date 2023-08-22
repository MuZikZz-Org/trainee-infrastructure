terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.19.1"
    }
    vault = {
      source = "hashicorp/vault"
      version = ">= 3.8.2"
    }
  }
}