resource "azurerm_bastion_host" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  sku                    = var.sku
  scale_units            = var.sku == "Standard" || var.sku == "Premium" ? var.scale_units : 2
  copy_paste_enabled     = var.copy_paste_enabled
  file_copy_enabled      = var.sku == "Standard" || var.sku == "Premium" ? var.file_copy_enabled : null
  ip_connect_enabled     = var.sku == "Standard" || var.sku == "Premium" ? var.ip_connect_enabled : null
  shareable_link_enabled = var.sku == "Standard" || var.sku == "Premium" ? var.shareable_link_enabled : null
  tunneling_enabled      = var.sku == "Standard" || var.sku == "Premium" ? var.tunneling_enabled : null
  kerberos_enabled       = var.sku == "Standard" || var.sku == "Premium" ? var.kerberos_enabled : null
  tags                   = var.tags

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}
