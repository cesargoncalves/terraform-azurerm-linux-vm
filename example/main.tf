resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "francecentral"
}

resource "azurerm_virtual_network" "example" {
  name                = "example"
  address_space       = ["10.0.0.0/20"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "example" {
  source = "../"

  name        = "example"
  image       = "Canonical,UbuntuServer,18.04-LTS"
  subnet_id   = azurerm_subnet.example.id
  resource_group = azurerm_resource_group.example.name
  custom_data = base64encode(data.template_file.init.rendered)
  environment = "dev"
  public_key  = file("~/.ssh/id_rsa.pub")

  network_security_rules = {
    "SSH" = { direction = "Inbound", protocol = "Tcp", destination_port_range = "22", source_address_prefix = "0.0.0.0/0" }
  }

  depends_on = [
    azurerm_resource_group.example
  ]
}
