Terraform module for provisioning a linux vm in Azure  
currently only suporting linux

### Usage:

```hcl
module "example" {
  source = "git::https://github.com/cesargoncalves/terraform-azurerm-linux-vm.git?ref=main"

  name        = "ubuntu"
  image       = "Canonical,UbuntuServer,18.04-LTS"
  subnet_id   = azurerm_subnet.example.id
  resource_group = azurerm_resource_group.example.name
  public_key  = file("~/.ssh/id_rsa.pub")

  network_security_rules = {
    "SSH" = { direction = "Inbound", protocol = "Tcp", destination_port_range = "22", source_address_prefix = "0.0.0.0/0" }
  }
}
```

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.56.0 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The instance name | `string` | `null` | yes |
| <a name="input_image"></a> [image](#input\_image) | Image which this Virtual Machine should be created from | `string` | `null` | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Tag environment | `string` | `dev` | no |
| <a name="input_resource_group"></a> [resource_group](#input\_resource\_group) | The name of the Resource Group in which the Virtual Machine should be created | `string` | `null` | yes |
| <a name="input_subnet_id"></a> [subnet_id](#input\_subnet\_id) | The ID of the Subnet where this Network Interface should be located in | `string` | `null` | yes |
| <a name="input_public_key"></a> [public_key](#input\_public\_key) | The Public Key which should be used for authentication | `string` | `""` | no |
| <a name="input_vm_size"></a> [vm_size](#input\_vm\_size) | The SKU which should be used for this Virtual Machine | `string` | `Standard_B1s` | no |
| <a name="input_storage_account_type"></a> [storage_account_type](#input\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk | `string` | `StandardSSD_LRS` | no |
| <a name="input_disk_size_gb"></a> [disk_size_gb](#input\_disk\_size\_gb) | The Size of the Internal OS Disk in GB | `number` | `64` | no |
| <a name="input_admin_username"></a> [admin_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine | `string` | `azureuser` | no |
| <a name="input_custom_data"></a> [custom_data](#input\_custom\_data) | The Base64-Encoded Custom Data which should be used for this Virtual Machine | `string` | `null` | no |
| <a name="input_ip_allocation_method"></a> [ip_allocation_method](#input\_ip\_allocation\_method) |  Defines the allocation method for the IP address | `string` | `Dynamic` | no |
| <a name="input_network_security_rules"></a> [network_security_rules](#input\_network\_security\_rules) | Security rules to be applied | `map(object)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to place in the resources | `map(string)` | `{}` | no |

### FAQ
* if `public_key` not defined, random `admin_password` is used
* inputs defaults according to https://azure.microsoft.com/en-us/pricing/free-services/

