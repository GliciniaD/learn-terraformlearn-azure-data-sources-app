resource "azurerm_network_interface" "app" {
  count               = var.instances_per_subnet * length(data.terraform_remote_state.network.outputs.private_subnet_ids)
  name                = "nic-app-${count.index}"
  location            = data.terraform_remote_state.network.outputs.location
  resource_group_name = data.terraform_remote_state.network.outputs.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.network.outputs.private_subnet_ids[count.index % length(data.terraform_remote_state.network.outputs.private_subnet_ids)]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "app" {
  count               = var.instances_per_subnet * length(data.terraform_remote_state.network.outputs.private_subnet_ids)
  name                = "vm-app-${count.index}"
  location            = data.terraform_remote_state.network.outputs.location
  resource_group_name = data.terraform_remote_state.network.outputs.resource_group_name
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.app[count.index].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file(var.ssh_public_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = data.azurerm_platform_image.ubuntu.version
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
```
