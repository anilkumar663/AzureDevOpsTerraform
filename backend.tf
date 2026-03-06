terraform {
  backend "azurerm" {
    resource_group_name   = "anil123"
    storage_account_name  = "anil663"
    container_name        = "prod"
    key                   = "prod.terraform.tfstate"
  }
}