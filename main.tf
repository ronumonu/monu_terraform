terraform {
  required_version = "1.0.11"

}

resource "azurerm_resource_group" "containerrg" {
  name     = "containerrg"
  location = "eastus"
}

resource "azurerm_storage_account" "test" {
  name                     = "mystoreacc"
  resource_group_name      = azurerm_resource_group.containerrg.name
  location                 = azurerm_resource_group.containerrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

tags = {
environment = "development"
}
}

resource "azurerm_storage_container" "azuresc" {
  name                  = "azuresc"
  storage_account_name  = azurerm_storage_account.test.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "azuress" {
  name                 = "azuress"
  storage_account_name = azurerm_storage_account.test.name
  quota                = 50
}

resource "azurerm_storage_queue" "azuresq" {
  name                 = "azuresq"
  storage_account_name = azurerm_storage_account.test.name
}

resource "azurerm_storage_table" "azurest" {
  name                 = "azurest"
  storage_account_name = azurerm_storage_account.test.name
}

resource "azurerm_container_registry" "ronu" {
  name                = "ronucontainer123"
  resource_group_name = azurerm_resource_group.containerrg.name
  location            = azurerm_resource_group.containerrg.location
  sku                 = "Basic"
  admin_enabled       = true
}
