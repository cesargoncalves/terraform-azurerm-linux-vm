output "instance_admin_username" {
  value = azurerm_linux_virtual_machine.this.admin_username
}

output "instance_admin_password" {
  value = random_string.random.result
}

output "instance_public_ip" {
  value = azurerm_public_ip.this.ip_address
}
