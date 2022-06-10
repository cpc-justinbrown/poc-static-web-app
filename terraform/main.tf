resource "azurerm_resource_group" "rg" {
  name     = "rgStaticWebApp"
  location = "centralus"
}

resource "azurerm_static_site" "swa" {
  name                = "swaStaticWebApp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Standard"
  sku_size            = "Standard"

  identity {
    type = "SystemAssigned"
  }
}