# terraform.tfvars
# -------------------------------------------------------------------
# Used during both `terraform plan` and `terraform apply` steps.
# This file holds non-sensitive values for variable substitution.
# Do NOT put secrets here — keep them in GitHub Secrets or Key Vault.
# -------------------------------------------------------------------

# Shared vars
resource_group_name  = "netcompany-rg"               # Used for all Azure resources
location             = "uksouth"                         # Azure region for deployment

# Frontend vars
cdn_endpoint_name    = "netcompany-resume"                  # Reserved for CDN if used in future
cdn_profile_name     = "netcompany-cdn-profile" # Required for Azure CDN 

frontend_origin_urls = ["https://netcompany-resume.azureedge.net"] # CORS whitelist for Function App, currently 1

storage_account_name = "netcompanywebstorage" 
