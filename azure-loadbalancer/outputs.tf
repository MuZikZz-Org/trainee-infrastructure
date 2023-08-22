output "public_ip" {
  value = module.loadbalancer.azurerm_public_ip_address
}