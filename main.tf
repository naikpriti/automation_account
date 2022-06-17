# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
    azapi = {
      source  = "Azure/azapi"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

provider "azapi" {
  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # subscription_id = "..."
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}


resource "azurerm_automation_account" "aa_demo" {
  name                = "aademops"
  location            = azurerm_resource_group.rg_automation_account.location
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
  scope              = "/subscriptions/149fdc07-203b-4014-9552-2dab6195289b"
  role_definition_name = "Contributor"
  principal_id       = azurerm_automation_account.example.identity[0].principal_id
}