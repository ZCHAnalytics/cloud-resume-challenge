# terraform.tfvars
# -------------------------------------------------------------------
# Used during both `terraform plan` and `terraform apply` steps.
# This file holds non-sensitive values for variable substitution.
# Do NOT put secrets here — keep them in GitHub Secrets or Key Vault.
# -------------------------------------------------------------------

# Backend vars
function_storage_name   = "zchresumefuncstorage"        # Storage used by the Azure Function App
function_app_name       = "resume-func-app"         # Azure Function App name (must be globally unique)
cosmosdb_account_name   = "resume-cosmos"                # CosmosDB account name
