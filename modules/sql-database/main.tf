resource "azurerm_mssql_database" "this" {
  name                        = var.name
  server_id                   = var.server_id
  collation                   = var.collation
  sku_name                    = var.sku_name
  max_size_gb                 = var.max_size_gb
  zone_redundant              = var.zone_redundant
  read_scale                  = var.read_scale
  storage_account_type        = var.storage_account_type
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  min_capacity                = var.min_capacity
  tags                        = var.tags
}
