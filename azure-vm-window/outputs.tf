output "vm_name" {
  description = "Virtual Machine Name and Computer Name"
  value = azurerm_windows_virtual_machine.vm[*].name 
}
output "admin_username" {
  description = "Admin Username"
  value = azurerm_windows_virtual_machine.vm[*].admin_username 
}
output "vm_size" {
  description = "Virtual Machine Size Type"
  value = azurerm_windows_virtual_machine.vm[*].size 
}
output "vm_zone" {
  description = "Virtual Machine Zone"
  value = azurerm_windows_virtual_machine.vm[*].zone 
}
output "vm_location" {
  description = "Virtual Machine Location"
  value = azurerm_windows_virtual_machine.vm[*].location 
}
output "vm_resource_group" {
  description = "Virtual Machine Resource Group"
  value = azurerm_windows_virtual_machine.vm[*].resource_group_name 
}
output "network_interface_private_ip" {
  description = "Private ip Addresses Of The VM Nics"
  value       = azurerm_network_interface.net[*].private_ip_address
}