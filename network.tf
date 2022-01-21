resource "azurerm_public_ip" "this" {
  name                = "${local.name}-public-ip"
  location            = data.azurerm_resource_group.selected.location
  resource_group_name = data.azurerm_resource_group.selected.name
  allocation_method   = var.ip_allocation_method

  tags = local.tags
}

resource "azurerm_network_interface" "this" {
  name                      = "${local.name}-nic"
  location                  = data.azurerm_resource_group.selected.location
  resource_group_name       = data.azurerm_resource_group.selected.name

  ip_configuration {
    name                          = "main-nic-confg"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_security_group" "this" {
  name                = local.name
  location            = data.azurerm_resource_group.selected.location
  resource_group_name = data.azurerm_resource_group.selected.name 
  tags                = local.tags
}

resource "azurerm_network_security_rule" "this" {
  for_each = var.network_security_rules

  name                        = each.key
  priority                    = sum([100,index(keys(var.network_security_rules),each.key)])
  direction                   = each.value.direction
  access                      = lookup(each.value, "access", "Allow")
  protocol                    = each.value.protocol
  source_port_range           = lookup(each.value, "source_port_range", "*")
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = azurerm_network_interface.this.private_ip_address
  resource_group_name         = data.azurerm_resource_group.selected.name
  network_security_group_name = azurerm_network_security_group.this.name
}
