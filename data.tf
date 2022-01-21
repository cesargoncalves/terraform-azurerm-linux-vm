data "azurerm_resource_group" "selected" {
  name = var.resource_group
}

data "azurerm_platform_image" "selected" {
  location  = data.azurerm_resource_group.selected.location
  publisher = element(split(",", var.image),0)
  offer     = element(split(",", var.image),1)
  sku       = element(split(",", var.image),2)
}

## https://github.com/hashicorp/terraform-provider-azurerm/issues/12794
#data "azurerm_ssh_public_key" "selected" {
#  name                = "azure-terraform"
#  resource_group_name = "azurerm"
#}
