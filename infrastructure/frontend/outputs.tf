# -----------------------------------------------------------------------------
# Frontend / Static Website Outputs
# -----------------------------------------------------------------------------

# The resource group where all frontend and backend resources are deployed
output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the resource group hosting the frontend and backend infrastructure"
}

# The Azure region used for the deployment
output "location" {
  value       = azurerm_resource_group.main.location
  description = "The Azure region"
}

# The public URL of the static website hosted in the storage account
output "static_site_url" {
  value       = azurerm_storage_account.frontend_storage.primary_web_endpoint
  description = "Primary web endpoint for the static frontend site"
}

# The name of the storage account used for the static website
output "storage_account_name" {
  value       = azurerm_storage_account.frontend_storage.name
  description = "The name of the Azure Storage account hosting the static website"
}

# The name of the Azure CDN endpoint (used for purging, deployment, etc.)
output "cdn_endpoint_name" {
  value       = azurerm_cdn_endpoint.cdn_endpoint.name
  description = "The name of the Azure CDN endpoint used for the frontend"
}

# The name of the Azure CDN profile associated with the endpoint
output "cdn_profile_name" {
  value       = azurerm_cdn_profile.cdn_profile.name
  description = "The Azure CDN profile name used for the frontend"
}

# The dynamically constructed output
output "cdn_endpoint_url" {
  value       = "https://${azurerm_cdn_endpoint.cdn_endpoint.name}.azureedge.net"
  description = "The fully qualified CDN URL used for serving static content and for CORS in backend"
}
