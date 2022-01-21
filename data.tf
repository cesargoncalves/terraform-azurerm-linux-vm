data "azurerm_resource_group" "selected" {
  name = var.resource_group
}

data "azurerm_platform_image" "selected" {
  location  = data.azurerm_resource_group.selected.location
  publisher = element(split(",", var.image),0)
  offer     = element(split(",", var.image),1)
  sku       = element(split(",", var.image),2)
}
