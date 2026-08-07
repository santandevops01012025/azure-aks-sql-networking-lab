resource "azurerm_resource_group" "this" {
  name       = var.name
  location   = var.location
  managed_by = var.managed_by
  tags       = var.tags
}

resource "azurerm_management_lock" "this" {
  count      = var.lock_level != null ? 1 : 0
  name       = coalesce(var.lock_name, "lock-${var.name}")
  scope      = azurerm_resource_group.this.id
  lock_level = var.lock_level
  notes      = "Resource Group protected by enterprise Management Lock."
}
