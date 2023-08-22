provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.workload_access_key
  client_secret   = var.workload_access_secretkey

}

provider "azurerm" {
  alias = "network"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.connectivity_subscription_info["subscription_id"]
  tenant_id       = var.tenant_id
  client_id       = var.network_access_key
  client_secret   = var.network_access_secretkey
}

provider "azurerm" {
  alias = "security"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.security_subscription_info["subscription_id"]
  tenant_id       = var.tenant_id
  client_id       = var.network_access_key
  client_secret   = var.network_access_secretkey
}