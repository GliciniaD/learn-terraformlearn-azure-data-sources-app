# The original tutorial's `aws_ami` data source finds the current Amazon Linux AMI for whatever region you're in, 
# instead of hard-coding an ID that only works in `us-east-1`. 
# The Azure equivalent is `azurerm_platform_image`, which finds the latest 
# published version of a Marketplace image:

data "azurerm_platform_image" "ubuntu" {
  location  = data.terraform_remote_state.network.outputs.location
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-jammy"
  sku       = "22_04-lts-gen2"
}

# Reference `data.azurerm_platform_image.ubuntu.version` wherever you'd otherwise hard-code an image version.