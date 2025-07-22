# ----- Terraform Settings -----
terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Use version 4.x (latest minor patch version will be used)
    }
  }
  required_version = ">= 1.12.0" # Ensure Terraform CLI is v1.0 or newer
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account for Static Website
resource "azurerm_storage_account" "frontend_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Enable static website hosting on the storage account
resource "azurerm_storage_account_static_website" "static_site" {
  storage_account_id = azurerm_storage_account.frontend_storage.id
  index_document     = "index.html"
  error_404_document = "404.html"
}

# CDN Profile required to create a CDN Endpoint
resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.cdn_profile_name  # e.g. "netcompany-cdn-profile"
  location            = "Global"
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard_Microsoft"
}

# CDN Endpoint to serve static site globally
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = var.cdn_endpoint_name # e.g. "netcompanhy-resume"
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  location            = "Global"
  resource_group_name = azurerm_resource_group.main.name

  origin {
    name      = "netcompany-resume-origin"
    host_name = azurerm_storage_account.frontend_storage.primary_web_host
  }

  origin_host_header = azurerm_storage_account.frontend_storage.primary_web_host

  delivery_rule {
    name  = "EnforceHTTPS"
    order = 1

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "PermanentRedirect"
      protocol      = "Https"
    }
  }
}
