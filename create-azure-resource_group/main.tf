locals {
  name           = format("%s-%s-%s",var.env_tags["company"],var.env_tags["project"],var.env_tags["Environment"])
}

##########################################################################################
# Resource Group
##########################################################################################

resource "azurerm_resource_group" "main" {
  name     = format("rg-%s",lower(local.name))
  location = var.resource_group_location
  
  tags = merge(
    #   var.common_tags,
      var.env_tags
  )
}
