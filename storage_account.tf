# //storage account
resource "azurerm_storage_account" "raw_storage" {
    name="${var.airline_name}rawdata"
    resource_group_name = azurerm_resource_group.new_airline_rg.name
    location = azurerm_resource_group.new_airline_rg.location
    account_kind = "StorageV2"
    account_tier = "Standard"
    account_replication_type = "LRS"
    access_tier = "Hot"
    allow_nested_items_to_be_public = false
    shared_access_key_enabled = true
    public_network_access_enabled = true
    is_hns_enabled = true
    large_file_share_enabled = false

    tags = {
        owner="FPT"
        env="test"
    }

    network_rules {
        default_action = "Deny"
        ip_rules = var.address_range
        virtual_network_subnet_ids= [azurerm_subnet.test_subnet.id]
    }

    blob_properties {
        delete_retention_policy {
          days=7
        }
  
        container_delete_retention_policy {
            days=7
        }
    }

    identity {
      type="UserAssigned"
      identity_ids = [azurerm_user_assigned_identity.test-UMA.id] 
    }

    customer_managed_key {
      key_vault_key_id= azurerm_key_vault_key.keyUMA.id
      user_assigned_identity_id=azurerm_user_assigned_identity.test-UMA.id //create managed identity first
    }
}

# //container
# # resource "azurerm_storage_container" "raw_container" {
# #   name                  = "test_container"
# #   storage_account_name  = azurerm_storage_account.raw_storage.name
# #   container_access_type = "private"
# # }

# # //blob
# # resource "azurerm_storage_blob" "raw_blob" {
# #   name                   = "file.json"
# #   storage_account_name   = azurerm_storage_account.raw_storage.name
# #   storage_container_name = azurerm_storage_container.raw_container.name
# #   type                   = "Block"
# #   source                 = "some-local-json-file.json"
#}