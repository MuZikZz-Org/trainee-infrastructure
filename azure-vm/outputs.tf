# output "resource_group_name" {
#   value = azurerm_resource_group.rg.name
# }

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

output "private_key" {
  value       = tls_private_key.example_ssh.private_key_pem
  sensitive   = true
  description = "Private key for SSH"
}

output "SONARQUBE_PORT" {
  value = var.SONARQUBE_PORT
}
