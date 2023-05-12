terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "application_name" {
  description = "Lynx web shop application."
  default = "lynx-web-shop"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner   = "Timo Lehtone"
    DueDate = "2023-05-31"
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "lynx_web_shop_dev" {
  name     = "${var.application_name}-dev-rg"
  location = "North Europe"
  tags = var.tags
}

resource "azurerm_service_plan" "lynx_web_shop_dev" {
  name                = "lynx-web-shop-plan"
  location            = azurerm_resource_group.lynx_web_shop_dev.location
  resource_group_name = azurerm_resource_group.lynx_web_shop_dev.name
  sku_name = "S1"
  os_type = "Linux"

  tags = var.tags
}

resource "azurerm_linux_web_app" "lynx_web_shop_dev" {
  name                = "${var.application_name}-dev"
  location            = azurerm_resource_group.lynx_web_shop_dev.location
  resource_group_name = azurerm_resource_group.lynx_web_shop_dev.name
  service_plan_id     = azurerm_service_plan.lynx_web_shop_dev.id

  site_config {}
  tags = var.tags
}
