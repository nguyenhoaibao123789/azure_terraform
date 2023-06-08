terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.58.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {} //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/features-block
  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  client_id         = var.client_id
  client_secret     = var.client_secret
}

resource "azurerm_resource_group" "new_airline_rg" {
  name     = "RG_${var.airline_name}"
  location = "Southeast Asia"
}

