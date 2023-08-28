terraform {
  backend "azurerm" {
    key                     = "##StateFile##"
    access_key              = "##TerraformStorageCredential##"
  }
}
