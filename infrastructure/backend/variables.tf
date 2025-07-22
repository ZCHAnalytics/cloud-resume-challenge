# =============================================================================
# Variables Declaration File
# Used by: main.tf and tfvars file, consumed during terraform plan/apply
# =============================================================================

variable "function_storage_name" {
  description = "Name of the storage account for the Function App"
  type        = string
  # Used in: Storage Account and Function App linkage
}

variable "function_app_name" {
  description = "Name of the Azure Function App"
  type        = string
  # Used in: Function App name 
}

variable "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  type        = string
  # Used in: Cosmos DB resource block
}
