locals {
  name                         = format("%s-%s-%s-%s",var.env_tags["Company"],var.env_tags["ProjectAbbrev"],var.env_tags["ServiceGroup"],var.env_tags["Environment"])
  subdomain_name               = substr(local.name, 0, 60)
  subnet_name                  = var.custom_subnet_name != "" ?  var.custom_subnet_name : var.subnet.name
  workload_resource_group_name = var.custom_workload_resource_group_name != "" ? var.custom_workload_resource_group_name : var.kubernetes["resource_group_name"]
}

##########################################################################################
# Resource Group
##########################################################################################
data "azurerm_resource_group" "main" {
  name = format("rg-%s",lower(local.name))
}

data "azurerm_resource_group" "workload" {
  name = local.workload_resource_group_name
}

##########################################################################################
# Virtual Network
##########################################################################################
data "azurerm_virtual_network" "network" {
  name                 = var.vnet.name
  resource_group_name  = var.vnet.resource_group_name
}

data "azurerm_subnet" "network" {
  name                 = local.subnet_name
  virtual_network_name = data.azurerm_virtual_network.network.name
  resource_group_name  = var.subnet.resource_group_name
}

##########################################################################################
# Log Analytics
##########################################################################################
data "azurerm_log_analytics_workspace" "log" {
  provider            = azurerm.security
  name                = var.log.name
  resource_group_name = var.log.resource_group_name
}

##########################################################################################
# Azure Loadbalancer module
##########################################################################################

module "loadbalancer" {
  source                                 = "git::https://gitlab.com/scbtechx/xplatform/fundamental-services/terraform-modules/products/azure-loadbalancer.git?ref=testing"
  loadbalancer_name                      = local.name
  resource_group_name                    = data.azurerm_resource_group.main.name
  resource_group_location                = data.azurerm_resource_group.main.location
  resource_group_id                      = data.azurerm_resource_group.main.id
  type                                   = var.lb_type
  subnet_id                              = data.azurerm_subnet.network.id
  frontend_private_ip_address_allocation = var.frontend_private_ip_address_allocation
  frontend_private_ip_address            = var.frontend_private_ip_address
  lb_sku                                 = var.lb_sku_name

  # remote_port = {
  #   ssh = ["Tcp", "22"]
  # }

  # lb_port = {
  #   http  = ["80", "Tcp", "80"]
  #   https = ["443", "Tcp", "443"]
  # }

  # lb_probe = {
  #   http  = ["Tcp", "80", ""]
  #   http2 = ["Http", "1443", "/"]
  # }

  tags = merge(
      var.common_tags,
      var.env_tags
  )
}

# ##########################################################################################
# # Private DNS
# ##########################################################################################
# resource "azurerm_private_dns_a_record" "agw" {
#   provider            = azurerm.network
#   name                =  format("lb-%s",local.subdomain_name)
#   zone_name           = var.connectivity_subscription_info["private_dns_zone_name"]
#   resource_group_name = var.connectivity_subscription_info["private_dns_zone_resource_group_name"]
#   ttl                 = 300
#   records             = [ module.loadbalancer.azurerm_public_ip_address ]

#   tags = merge(
#       var.common_tags,
#       var.env_tags
#   )
# }