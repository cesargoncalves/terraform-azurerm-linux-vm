### Simple example:

```hcl
module "example" {
  source = "git::https://github.com/cesargoncalves/terraform-azurerm-linux-vm.git?ref=main"

  name        = "ubuntu"
  image       = "Canonical,UbuntuServer,18.04-LTS"
  subnet_id   = azurerm_subnet.example.id
  resource_group = azurerm_resource_group.example.name
  environment = "dev"
  public_key  = file("~/.ssh/id_rsa.pub")

  network_security_rules = {
    "SSH" = { direction = "Inbound", protocol = "Tcp", destination_port_range = "22", source_address_prefix = "0.0.0.0/0" }
  }
}
```
