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
