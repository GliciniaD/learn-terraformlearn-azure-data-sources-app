
##So this is fectching data from already existing and filled it (outputs) from anotheer repo.

data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "saastfstatedata"
    container_name        = "containertfstatedata"
    key                   = "network.tfstate"
  }
}


provider "azurerm" {
  features {}
}

