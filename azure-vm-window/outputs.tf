output "network_interface_private_ip" {
  description = "Private ip Addresses Of The VM Nics"
  value       = azurerm_network_interface.net[*].private_ip_address
}
