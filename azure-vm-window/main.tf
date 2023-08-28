locals {
  name                = format("%s-%s-%s-%s",var.env_tags["Company"],var.env_tags["ProjectAbbrev"],var.env_tags["ServiceGroup"],var.env_tags["Environment"])
  resource_group_name = element(coalescelist(data.azurerm_resource_group.main.*.name, azurerm_resource_group.main.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.main.*.location, azurerm_resource_group.main.*.location, [""]), 0)
  subnet_name         = var.custom_subnet_name != "" ?  var.custom_subnet_name : var.subnet.name
  specific_win_name   = format("%s-%s-%s",var.env_tags["ProjectAbbrev"],var.env_tags["ServiceGroup"],var.env_tags["Environment"])
  vm_name             = var.custom_vm_name != "" ? var.custom_vm_name : format("%s",local.specific_win_name)
}

##########################################################################################
# Resource Group
##########################################################################################
data "azurerm_resource_group" "main" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.custom_resource_group_name != "" ? var.custom_resource_group_name : format("rg-%s",lower(local.name))
}

resource "azurerm_resource_group" "main" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.custom_resource_group_name != "" ? var.custom_resource_group_name : format("rg-%s",lower(local.name))
  location = var.az_location_name
  tags = merge(
    var.env_tags
  )
}

##########################################################################################
# Virtual Network
##########################################################################################
data "azurerm_virtual_network" "network" {
  name                 = var.vnet.name
  resource_group_name  = var.vnet.resource_group_name
}
############################ subnet ##########################
data "azurerm_subnet" "network" {
  name                 = local.subnet_name
  virtual_network_name = data.azurerm_virtual_network.network.name
  resource_group_name  = var.subnet.resource_group_name
}


##########################################################################################
# Security Group
##########################################################################################
resource "azurerm_network_security_group" "sg" {
  name                = format("sg-%s",local.name)
  location            = local.location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "SSHPort"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

##########################################################################################
# Network Interface
##########################################################################################
 resource "azurerm_network_interface" "net" {
   count               = var.instance_count
   name                = format("net-int-%s-%02d",local.name,count.index+1)
   location            = local.location
   resource_group_name = local.resource_group_name
   tags = merge(
    var.env_tags
   )

   ip_configuration {
     name                          = format("ip-conf-%s-%02d",local.name,count.index+1)
     subnet_id                     = data.azurerm_subnet.network.id
     private_ip_address_allocation = "Dynamic"
   }
 }


resource "azurerm_windows_virtual_machine" "vm" {
   count                 = var.instance_count
   name                  = format("%s-%02d",local.vm_name,count.index+1)
   location            = local.location
   resource_group_name = local.resource_group_name
   network_interface_ids = [element(azurerm_network_interface.net.*.id, count.index)]
   size                  = var.vm_size
   admin_username        = var.os_admin_username
   admin_password        = var.os_admin_password
   hotpatching_enabled   = false
   patch_mode            = var.patch_mode
   zone                  = var.vm_zone
   # Uncomment this line to delete the OS disk automatically when deleting the VM
  #  delete_os_disk_on_termination = true

   # Uncomment this line to delete the data disks automatically when deleting the VM
  #  delete_data_disks_on_termination = true

    source_image_reference {
      publisher = var.imageReference.publisher
      offer     = var.imageReference.offer
      sku       = var.imageReference.sku
      version   = var.imageReference.version
    }

   os_disk {
     caching              = "ReadWrite"
     storage_account_type = "Standard_LRS"
   }

   timezone = "SE Asia Standard Time"

   tags = merge(
    var.env_tags
   )
   depends_on = [
    azurerm_network_security_group.sg,
    azurerm_network_interface.net
  ]
 }

 resource "azurerm_network_interface_security_group_association" "networkassociation" {
  count                     = var.instance_count 
  network_interface_id      = azurerm_network_interface.net[count.index].id
  network_security_group_id = azurerm_network_security_group.sg.id
  depends_on = [
    azurerm_network_security_group.sg,
    azurerm_network_interface.net
  ]
}
 

