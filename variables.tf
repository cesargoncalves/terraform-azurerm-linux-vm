variable "name" {
  type = string
}

variable "image" {
  type = string
}

variable "environment" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "subnet_id" {  
  type = string
}

variable "public_key" {
  type    = string
  default = ""
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "storage_account_type" {
  type    = string
  default = "StandardSSD_LRS"
}

variable "disk_size_gb" {
  type    = number
  default = 64
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "custom_data" {
  type    = string
  default = null
}

variable "ip_allocation_method" {
  type    = string
  default = "Dynamic"
}

variable "network_security_rules" {
  type    = map(object({
    direction                   = string
    protocol                    = string
    destination_port_range      = string
    source_address_prefix       = string
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
