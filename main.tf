resource "random_string" "random" {
  length           = 24
  special          = false
}

resource "azurerm_linux_virtual_machine" "this" {
  name                  = local.name
  resource_group_name   = data.azurerm_resource_group.selected.name
  location              = data.azurerm_resource_group.selected.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  custom_data           = var.custom_data 
  network_interface_ids = [azurerm_network_interface.this.id]

  disable_password_authentication = var.public_key != "" ? true : false
  admin_password                  = var.public_key != "" ? null : random_string.random.result

  dynamic "admin_ssh_key" {
    for_each = var.public_key != "" ? ["dummy"] : []
    content {
      username   = var.admin_username
      public_key = var.public_key
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type 
    disk_size_gb         = var.disk_size_gb
  }

  ## https://github.com/terraform-providers/terraform-provider-azurerm/issues/6745
  #source_image_id = data.azurerm_platform_image.selected.id
  
  source_image_reference {
    publisher = data.azurerm_platform_image.selected.publisher
    offer     = data.azurerm_platform_image.selected.offer
    sku       = data.azurerm_platform_image.selected.sku
    version   = data.azurerm_platform_image.selected.version
  }
  
  tags = local.tags
}

locals {
  name = lower(trimspace(var.name))
  tags = merge(
    var.tags,
    {"name" = local.name},
    {"environment" = var.environment},
    {"location" = data.azurerm_resource_group.selected.location},
    {"terraform" = "true"}
  )
}
