provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.workload_access_key
  client_secret   = var.workload_access_secretkey
}
