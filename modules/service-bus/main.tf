resource "azurerm_servicebus_namespace" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  capacity                      = var.sku == "Premium" ? var.capacity : 0
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version
  tags                          = var.tags

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}

resource "azurerm_servicebus_queue" "this" {
  for_each                             = var.queues
  name                                 = each.key
  namespace_id                         = azurerm_servicebus_namespace.this.id
  enable_partitioning                  = each.value.enable_partitioning
  max_size_in_megabytes                = each.value.max_size_in_megabytes
  requires_duplicate_detection         = each.value.requires_duplicate_detection
  requires_session                     = each.value.requires_session
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration
  max_delivery_count                   = each.value.max_delivery_count
  lock_duration                        = each.value.lock_duration
  default_message_ttl                  = each.value.default_message_ttl
  auto_delete_on_idle                  = each.value.auto_delete_on_idle
}

resource "azurerm_servicebus_topic" "this" {
  for_each                     = var.topics
  name                         = each.key
  namespace_id                 = azurerm_servicebus_namespace.this.id
  enable_partitioning          = each.value.enable_partitioning
  max_size_in_megabytes        = each.value.max_size_in_megabytes
  requires_duplicate_detection = each.value.requires_duplicate_detection
  default_message_ttl          = each.value.default_message_ttl
  auto_delete_on_idle          = each.value.auto_delete_on_idle
}

locals {
  servicebus_subscriptions = flatten([
    for topic_key, topic_val in var.topics : [
      for sub_key, sub_val in topic_val.subscriptions : {
        composite_key = "${topic_key}:${sub_key}"
        topic_key     = topic_key
        sub_name      = sub_key
        sub_val       = sub_val
      }
    ]
  ])
}

resource "azurerm_servicebus_subscription" "this" {
  for_each                             = { for sub in local.servicebus_subscriptions : sub.composite_key => sub }
  name                                 = each.value.sub_name
  topic_id                             = azurerm_servicebus_topic.this[each.value.topic_key].id
  max_delivery_count                   = each.value.sub_val.max_delivery_count
  dead_lettering_on_message_expiration = each.value.sub_val.dead_lettering_on_message_expiration
  lock_duration                        = each.value.sub_val.lock_duration
  requires_session                     = each.value.sub_val.requires_session
  default_message_ttl                  = each.value.sub_val.default_message_ttl
}
