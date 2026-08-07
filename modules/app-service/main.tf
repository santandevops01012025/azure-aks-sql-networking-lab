resource "azurerm_service_plan" "this" {
  name                   = var.plan_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  os_type                = var.os_type
  sku_name               = var.sku_name
  worker_count           = var.worker_count
  zone_balancing_enabled = var.zone_balancing_enabled
  tags                   = var.tags
}

resource "azurerm_linux_web_app" "this" {
  for_each                      = var.os_type == "Linux" ? var.web_apps : {}
  name                          = each.key
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = azurerm_service_plan.this.id
  https_only                    = each.value.https_only
  public_network_access_enabled = each.value.public_network_access_enabled
  virtual_network_subnet_id     = each.value.virtual_network_subnet_id
  app_settings                  = each.value.app_settings
  tags                          = var.tags

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  site_config {
    always_on           = each.value.site_config.always_on
    ftps_state          = each.value.site_config.ftps_state
    http2_enabled       = each.value.site_config.http2_enabled
    minimum_tls_version = each.value.site_config.minimum_tls_version

    dynamic "application_stack" {
      for_each = each.value.site_config.application_stack != null ? [each.value.site_config.application_stack] : []
      content {
        node_version        = application_stack.value.node_version
        python_version      = application_stack.value.python_version
        dotnet_version      = application_stack.value.dotnet_version
        java_version        = application_stack.value.java_version
        docker_image_name   = application_stack.value.docker_image_name
        docker_registry_url = application_stack.value.docker_registry_url
      }
    }
  }
}

resource "azurerm_windows_web_app" "this" {
  for_each                      = var.os_type == "Windows" ? var.web_apps : {}
  name                          = each.key
  resource_group_name           = var.resource_group_name
  location                      = var.location
  service_plan_id               = azurerm_service_plan.this.id
  https_only                    = each.value.https_only
  public_network_access_enabled = each.value.public_network_access_enabled
  virtual_network_subnet_id     = each.value.virtual_network_subnet_id
  app_settings                  = each.value.app_settings
  tags                          = var.tags

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  site_config {
    always_on           = each.value.site_config.always_on
    ftps_state          = each.value.site_config.ftps_state
    http2_enabled       = each.value.site_config.http2_enabled
    minimum_tls_version = each.value.site_config.minimum_tls_version

    dynamic "application_stack" {
      for_each = each.value.site_config.application_stack != null ? [each.value.site_config.application_stack] : []
      content {
        node_version   = application_stack.value.node_version
        dotnet_version = application_stack.value.dotnet_version
        java_version   = application_stack.value.java_version
      }
    }
  }
}
