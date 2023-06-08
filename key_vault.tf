resource "azurerm_key_vault" "test_KV" {
    name                        = "KV-${var.airline_name}"
    location                    = azurerm_resource_group.new_airline_rg.location
    resource_group_name         = azurerm_resource_group.new_airline_rg.name
    enabled_for_disk_encryption = true
    enabled_for_deployment = true
    //enable_rbac_authorization = true
    public_network_access_enabled = true
    tenant_id                   = var.tenant_id
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true


    sku_name = "standard"

    access_policy {
        tenant_id = var.tenant_id
        object_id = var.object_id

        //enabled_for_deployment= "true"
        //enabled_for_disk_encryption= "true"
    
        key_permissions = [
            "Create",
            "List",
            "Delete",
            "Get",
            "Purge",
            "Recover",
            "Update",
            "GetRotationPolicy",
            "SetRotationPolicy"
            ]

        secret_permissions = [
            "Set",
            "Get",
            "Delete",
            "Purge",
            "Recover"
            ]
    }

    # network_acls {
    #   bypass= "AzureServices"
    #   default_action="Allow"
    # #   ip_rules= var.ip_address
    # #   virtual_network_subnet_ids=[azurerm_subnet.test_subnet.id]
    # }
}

# //key vault's key
resource "azurerm_key_vault_key" "keyUMA" {
  name         = "${var.airline_name}-KV-key-UMA"
  key_vault_id = azurerm_key_vault.test_KV.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
# //key vault's secret
# resource "azurerm_key_vault_secret" "test_KV_secret1" {
#   name         = "secret-sauce"
#   value        = "szechuan"
#   key_vault_id = azurerm_key_vault.test_KV.id
# }