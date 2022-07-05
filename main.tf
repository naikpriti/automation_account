terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.5.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "149fdc07-203b-4014-9552-2dab6195289b"
  #client_id       = "6fea9247-494c-46bf-9ef9-06e22218a4a3"
  #client_secret   = "Lzq8Q~DNXgu37MIj1fC-tDxWYKyGz16ymTJTEasf"
  tenant_id       = "71da3921-d9d0-4946-a824-72fc3472839b"
}


resource "azurerm_automation_account" "aa_demo" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "Basic"

  identity {
     type = "SystemAssigned"
  }

}

/*resource "azurerm_automation_credential" "example-Credential" {
  name                    = "MSSQLCredential"
  resource_group_name     = azurerm_resource_group.rg_automation_account.name
  automation_account_name = azurerm_automation_account.aa_demo.name
  username                = "LN_demo_admin"
  password                = "Alpharetta1"
  description             = "This is an example credential"
}*/


resource "azurerm_role_assignment" "example" {
  scope              = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id       = azurerm_automation_account.aa_demo.identity[0].principal_id
}
