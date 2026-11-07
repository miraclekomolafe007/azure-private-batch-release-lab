terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "res-1" {
  location = "spaincentral"
  name     = "RG-PROJ-1"
  tags = {
    DeleteBy = "2026-10-24"
    Owner    = "Miracle"
    Project  = "AZ700-Batch"
  }
}
resource "azurerm_ssh_public_key" "res-1" {
  location            = "spaincentral"
  name                = "SSHKEY-BATCH"
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLf+hF7BBcCQDs995fXzFZj5mkUrJYT3Lh5+zWAs8EPx09ZBQ7AL75wh+8+D5rBD6bwXNGJToXe2ylpg9H4KoJra5oyg+dXUI/k3jL7l28IdUu/IY9S+ZxzPBg9EFhZn1vad+pPF8mvgwVWBfuKtumceLW0oN9uogjQhRuk7bvtBcNp5mnRDboHYJuug+WC2FyR+d75S7YMYGowFQaeN94gp+KIhFLUp1i98csxkXHzy7/Mncc4xznjVYS92LweacsL004jkvukq5eEnVHJqT1kjRoYkf/wmrEYsYAoy1GTRsQX32GHZLtFtk0omVtWVo44dEZwUYns/3nhjvgAIGPpgROxZQ+vPF203mKshDXmNHEWlXC7GjoaVdxp1EQUEAHWvD5eg3Pqw8yAz+4HIT7rxaipl+FWlGDNCuUjhhxYDiDvcuyexDucSdSHtyJtL0oHEyOX2/Y72u1HZZAbTxh7KjnAqooAnlKCZkKn2sxqXStU7de9ZpnONgi92SBP0E= generated-by-azure"
  resource_group_name = azurerm_resource_group.res-1.name
}
resource "azurerm_linux_virtual_machine" "res-1" {
  admin_username                  = "azureuser"
  allow_extension_operations      = true
  computer_name                   = "VM-BATCH-ACCESS"
  disable_password_authentication = true
  disk_controller_type            = "SCSI"
  location                        = "spaincentral"
  name                            = "VM-BATCH-ACCESS"
  network_interface_ids           = [azurerm_network_interface.res-1.id]
  os_managed_disk_id              = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Compute/disks/VM-BATCH-ACCESS_OsDisk_1_7798512160154fa5a9bcea79a7f45663"
  patch_assessment_mode           = "ImageDefault"
  patch_mode                      = "ImageDefault"
  provision_vm_agent              = true
  resource_group_name             = azurerm_resource_group.res-1.name
  size                            = "Standard_B2ls_v2"
  tags = {
    DeleteBy = "2026-10-24"
    Owner    = "Miracle"
    Project  = "AZ700-Batch"
  }
  vm_agent_platform_updates_enabled = true
  additional_capabilities {
  }
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLf+hF7BBcCQDs995fXzFZj5mkUrJYT3Lh5+zWAs8EPx09ZBQ7AL75wh+8+D5rBD6bwXNGJToXe2ylpg9H4KoJra5oyg+dXUI/k3jL7l28IdUu/IY9S+ZxzPBg9EFhZn1vad+pPF8mvgwVWBfuKtumceLW0oN9uogjQhRuk7bvtBcNp5mnRDboHYJuug+WC2FyR+d75S7YMYGowFQaeN94gp+KIhFLUp1i98csxkXHzy7/Mncc4xznjVYS92LweacsL004jkvukq5eEnVHJqT1kjRoYkf/wmrEYsYAoy1GTRsQX32GHZLtFtk0omVtWVo44dEZwUYns/3nhjvgAIGPpgROxZQ+vPF203mKshDXmNHEWlXC7GjoaVdxp1EQUEAHWvD5eg3Pqw8yAz+4HIT7rxaipl+FWlGDNCuUjhhxYDiDvcuyexDucSdSHtyJtL0oHEyOX2/Y72u1HZZAbTxh7KjnAqooAnlKCZkKn2sxqXStU7de9ZpnONgi92SBP0E= generated-by-azure"
    username   = "azureuser"
  }
  boot_diagnostics {
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = 30
    name                 = "VM-BATCH-ACCESS_OsDisk_1_7798512160154fa5a9bcea79a7f45663"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer     = "ubuntu-22_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
}
resource "azurerm_linux_virtual_machine" "res-2" {
  admin_username                    = "azureuser"
  allow_extension_operations        = true
  computer_name                     = "VM-WAREHOUSE"
  disable_password_authentication   = true
  disk_controller_type              = "SCSI"
  location                          = "spaincentral"
  name                              = "VM-WAREHOUSE"
  network_interface_ids             = [azurerm_network_interface.res-2.id]
  os_managed_disk_id                = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Compute/disks/VM-WAREHOUSE_OsDisk_1_d50f8e8c5d01418c931e2fafecd90bfe"
  patch_assessment_mode             = "ImageDefault"
  patch_mode                        = "ImageDefault"
  provision_vm_agent                = true
  resource_group_name               = azurerm_resource_group.res-1.name
  secure_boot_enabled               = true
  size                              = "Standard_B2ls_v2"
  vm_agent_platform_updates_enabled = true
  vtpm_enabled                      = true
  additional_capabilities {
  }
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLf+hF7BBcCQDs995fXzFZj5mkUrJYT3Lh5+zWAs8EPx09ZBQ7AL75wh+8+D5rBD6bwXNGJToXe2ylpg9H4KoJra5oyg+dXUI/k3jL7l28IdUu/IY9S+ZxzPBg9EFhZn1vad+pPF8mvgwVWBfuKtumceLW0oN9uogjQhRuk7bvtBcNp5mnRDboHYJuug+WC2FyR+d75S7YMYGowFQaeN94gp+KIhFLUp1i98csxkXHzy7/Mncc4xznjVYS92LweacsL004jkvukq5eEnVHJqT1kjRoYkf/wmrEYsYAoy1GTRsQX32GHZLtFtk0omVtWVo44dEZwUYns/3nhjvgAIGPpgROxZQ+vPF203mKshDXmNHEWlXC7GjoaVdxp1EQUEAHWvD5eg3Pqw8yAz+4HIT7rxaipl+FWlGDNCuUjhhxYDiDvcuyexDucSdSHtyJtL0oHEyOX2/Y72u1HZZAbTxh7KjnAqooAnlKCZkKn2sxqXStU7de9ZpnONgi92SBP0E= generated-by-azure"
    username   = "azureuser"
  }
  boot_diagnostics {
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = 30
    name                 = "VM-WAREHOUSE_OsDisk_1_d50f8e8c5d01418c931e2fafecd90bfe"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer     = "ubuntu-22_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "res-1" {
  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true
  location                       = "spaincentral"
  name                           = "vm-batch-access80"
  resource_group_name            = azurerm_resource_group.res-1.name
  tags = {
    DeleteBy = "2026-10-24"
    Owner    = "Miracle"
    Project  = "AZ700-Batch"
  }
  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    private_ip_address            = "10.10.2.4"
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.res-1.id
    subnet_id                     = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-HUB/subnets/SNET-ACCESS"
  }
  depends_on = [
    # One of azurerm_subnet.res-1,azurerm_subnet_network_security_group_association.res-1 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_network_interface" "res-2" {
  accelerated_networking_enabled = true
  location                       = "spaincentral"
  name                           = "vm-warehouse900"
  resource_group_name            = azurerm_resource_group.res-1.name
  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    private_ip_address            = "10.30.1.4"
    private_ip_address_allocation = "Static"
    subnet_id                     = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-WAREHOUSE/subnets/SNET-WAREHOUSE"
  }
  depends_on = [
    # One of azurerm_subnet.res-4,azurerm_subnet_network_security_group_association.res-4,azurerm_subnet_route_table_association.res-2 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_network_security_group" "res-1" {
  location            = "spaincentral"
  name                = "NSG-BATCH-ACCESS"
  resource_group_name = azurerm_resource_group.res-1.name
  security_rule = [{
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = ""
    destination_address_prefixes               = ["10.20.1.4/32", "10.30.1.4/32"]
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Outbound"
    name                                       = "ALLOW-VPN-SSH-OUT"
    priority                                   = 100
    protocol                                   = "Tcp"
    source_address_prefix                      = "172.27.240.2/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.10.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "ALLOW-ADMIN-SSH"
    priority                                   = 110
    protocol                                   = "Tcp"
    source_address_prefix                      = "102.89.76.86/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.10.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "TEMP-VPN-SSH-TEST"
    priority                                   = 120
    protocol                                   = "Tcp"
    source_address_prefix                      = "197.211.59.95/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.10.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "TEMP-VPN-SSH-TEST-2"
    priority                                   = 130
    protocol                                   = "Tcp"
    source_address_prefix                      = "40.77.167.50/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.10.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "51820"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "ALLOW-WIREGUARD"
    priority                                   = 100
    protocol                                   = "Udp"
    source_address_prefix                      = "102.89.76.86/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Deny"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "*"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "DENY-OTHER"
    priority                                   = 4000
    protocol                                   = "*"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
}
resource "azurerm_network_security_rule" "res-1" {
  access                      = "Allow"
  destination_address_prefix  = "10.10.2.4/32"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "ALLOW-ADMIN-SSH"
  network_security_group_name = "NSG-BATCH-ACCESS"
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "102.89.76.86/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-2" {
  access                       = "Allow"
  destination_address_prefixes = ["10.20.1.4/32", "10.30.1.4/32"]
  destination_port_range       = "22"
  direction                    = "Outbound"
  name                         = "ALLOW-VPN-SSH-OUT"
  network_security_group_name  = "NSG-BATCH-ACCESS"
  priority                     = 100
  protocol                     = "Tcp"
  resource_group_name          = azurerm_resource_group.res-1.name
  source_address_prefix        = "172.27.240.2/32"
  source_port_range            = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-3" {
  access                      = "Allow"
  destination_address_prefix  = "10.10.2.4/32"
  destination_port_range      = "51820"
  direction                   = "Inbound"
  name                        = "ALLOW-WIREGUARD"
  network_security_group_name = "NSG-BATCH-ACCESS"
  priority                    = 100
  protocol                    = "Udp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "102.89.76.86/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-4" {
  access                      = "Deny"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "DENY-OTHER"
  network_security_group_name = "NSG-BATCH-ACCESS"
  priority                    = 4000
  protocol                    = "*"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-5" {
  access                      = "Allow"
  destination_address_prefix  = "10.10.2.4/32"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "TEMP-VPN-SSH-TEST"
  network_security_group_name = "NSG-BATCH-ACCESS"
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "197.211.59.95/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_rule" "res-6" {
  access                      = "Allow"
  destination_address_prefix  = "10.10.2.4/32"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "TEMP-VPN-SSH-TEST-2"
  network_security_group_name = "NSG-BATCH-ACCESS"
  priority                    = 130
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "40.77.167.50/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_network_security_group" "res-2" {
  location            = "spaincentral"
  name                = "NSG-BATCH-PE"
  resource_group_name = azurerm_resource_group.res-1.name
  security_rule = [{
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.20.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "443"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "ALLOW-ACCESS-SNAT"
    priority                                   = 110
    protocol                                   = "Tcp"
    source_address_prefix                      = "10.10.2.4/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.20.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "443"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "ALLOW-QUALITY"
    priority                                   = 100
    protocol                                   = "Tcp"
    source_address_prefix                      = "10.20.1.0/24"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Deny"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "*"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "DENY-OTHER"
    priority                                   = 4000
    protocol                                   = "*"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Deny"
    description                                = ""
    destination_address_prefix                 = "10.20.2.4/32"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "443"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "DENY-WAREHOUSE"
    priority                                   = 120
    protocol                                   = "Tcp"
    source_address_prefix                      = "10.30.0.0/16"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
}
resource "azurerm_network_security_rule" "res-7" {
  access                      = "Allow"
  destination_address_prefix  = "10.20.2.4/32"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "ALLOW-ACCESS-SNAT"
  network_security_group_name = "NSG-BATCH-PE"
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "10.10.2.4/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-8" {
  access                      = "Allow"
  destination_address_prefix  = "10.20.2.4/32"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "ALLOW-QUALITY"
  network_security_group_name = "NSG-BATCH-PE"
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "10.20.1.0/24"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-9" {
  access                      = "Deny"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "DENY-OTHER"
  network_security_group_name = "NSG-BATCH-PE"
  priority                    = 4000
  protocol                    = "*"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-10" {
  access                      = "Deny"
  destination_address_prefix  = "10.20.2.4/32"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "DENY-WAREHOUSE"
  network_security_group_name = "NSG-BATCH-PE"
  priority                    = 120
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "10.30.0.0/16"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-2,
  ]
}
resource "azurerm_network_security_group" "res-3" {
  location            = "spaincentral"
  name                = "NSG-BATCH-QUALITY"
  resource_group_name = azurerm_resource_group.res-1.name
  security_rule = [{
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.20.1.0/24"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "ALLOW-VPN-SSH"
    priority                                   = 100
    protocol                                   = "Tcp"
    source_address_prefix                      = "172.27.240.2/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Deny"
    description                                = ""
    destination_address_prefix                 = "10.20.1.0/24"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "*"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "DENY-OTHER"
    priority                                   = 4000
    protocol                                   = "*"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
}
resource "azurerm_network_security_rule" "res-11" {
  access                      = "Allow"
  destination_address_prefix  = "10.20.1.0/24"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "ALLOW-VPN-SSH"
  network_security_group_name = "NSG-BATCH-QUALITY"
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "172.27.240.2/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-3,
  ]
}
resource "azurerm_network_security_rule" "res-12" {
  access                      = "Deny"
  destination_address_prefix  = "10.20.1.0/24"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "DENY-OTHER"
  network_security_group_name = "NSG-BATCH-QUALITY"
  priority                    = 4000
  protocol                    = "*"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-3,
  ]
}
resource "azurerm_network_security_group" "res-4" {
  location            = "spaincentral"
  name                = "NSG-BATCH-WAREHOUSE"
  resource_group_name = azurerm_resource_group.res-1.name
  security_rule = [{
    access                                     = "Allow"
    description                                = ""
    destination_address_prefix                 = "10.30.1.0/24"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "22"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "ALLOW-VPN-SSH"
    priority                                   = 100
    protocol                                   = "Tcp"
    source_address_prefix                      = "172.27.240.2/32"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
    }, {
    access                                     = "Deny"
    description                                = ""
    destination_address_prefix                 = "*"
    destination_address_prefixes               = []
    destination_application_security_group_ids = []
    destination_port_range                     = "*"
    destination_port_ranges                    = []
    direction                                  = "Inbound"
    name                                       = "DENY-OTHER"
    priority                                   = 4000
    protocol                                   = "*"
    source_address_prefix                      = "*"
    source_address_prefixes                    = []
    source_application_security_group_ids      = []
    source_port_range                          = "*"
    source_port_ranges                         = []
  }]
}
resource "azurerm_network_security_rule" "res-13" {
  access                      = "Allow"
  destination_address_prefix  = "10.30.1.0/24"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "ALLOW-VPN-SSH"
  network_security_group_name = "NSG-BATCH-WAREHOUSE"
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "172.27.240.2/32"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_network_security_rule" "res-14" {
  access                      = "Deny"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "DENY-OTHER"
  network_security_group_name = "NSG-BATCH-WAREHOUSE"
  priority                    = 4000
  protocol                    = "*"
  resource_group_name         = azurerm_resource_group.res-1.name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_private_dns_zone" "res-1" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.res-1.name
  soa_record {
    email = "azureprivatedns-host.microsoft.com"
  }
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-1" {
  name                  = "link-hub"
  private_dns_zone_name = "privatelink.blob.core.windows.net"
  resolution_policy     = "Default"
  resource_group_name   = azurerm_resource_group.res-1.name
  virtual_network_id    = azurerm_virtual_network.res-1.id
  depends_on = [
    azurerm_private_dns_zone.res-1,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-2" {
  name                  = "link-warehouse"
  private_dns_zone_name = "privatelink.blob.core.windows.net"
  resolution_policy     = "Default"
  resource_group_name   = azurerm_resource_group.res-1.name
  virtual_network_id    = azurerm_virtual_network.res-3.id
  depends_on = [
    azurerm_private_dns_zone.res-1,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-3" {
  name                  = "ynielxuyie6ky"
  private_dns_zone_name = "privatelink.blob.core.windows.net"
  resolution_policy     = "Default"
  resource_group_name   = azurerm_resource_group.res-1.name
  virtual_network_id    = azurerm_virtual_network.res-2.id
  depends_on = [
    azurerm_private_dns_zone.res-1,
  ]
}
resource "azurerm_private_endpoint" "res-1" {
  custom_network_interface_name = "pe-batch-blob-nic"
  location                      = "spaincentral"
  name                          = "pe-batch-blob"
  resource_group_name           = azurerm_resource_group.res-1.name
  subnet_id                     = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-QUALITY/subnets/SNET-PRIVATE-ENDPOINT"
  ip_configuration {
    member_name        = "blob"
    name               = "ipconfig-batch-blob"
    private_ip_address = "10.20.2.4"
    subresource_name   = "blob"
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.res-1.id]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "pe-batch-blob"
    private_connection_resource_id = azurerm_storage_account.res-1.id
    subresource_names              = ["blob"]
  }
  depends_on = [
    # One of azurerm_subnet.res-2,azurerm_subnet_network_security_group_association.res-2 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_public_ip" "res-1" {
  allocation_method   = "Static"
  location            = "spaincentral"
  name                = "pip-batch-access"
  resource_group_name = azurerm_resource_group.res-1.name
  tags = {
    DeleteBy = "2026-10-24"
    Owner    = "Miracle"
    Project  = "AZ700-Batch"
  }
}
resource "azurerm_route_table" "res-1" {
  location            = "spaincentral"
  name                = "RT-BATCH-VPN-RETURN"
  resource_group_name = azurerm_resource_group.res-1.name
  route = [{
    address_prefix         = "172.27.240.0/24"
    name                   = "RETURN-TO-WIREGUARD"
    next_hop_in_ip_address = "10.10.2.4"
    next_hop_type          = "VirtualAppliance"
  }]
}
resource "azurerm_route" "res-1" {
  address_prefix         = "172.27.240.0/24"
  name                   = "RETURN-TO-WIREGUARD"
  next_hop_in_ip_address = "10.10.2.4"
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = azurerm_resource_group.res-1.name
  route_table_name       = "RT-BATCH-VPN-RETURN"
  depends_on = [
    azurerm_route_table.res-1,
  ]
}
resource "azurerm_virtual_network" "res-1" {
  address_space       = ["10.10.0.0/16"]
  location            = "spaincentral"
  name                = "VNET-BATCH-HUB"
  resource_group_name = azurerm_resource_group.res-1.name
  subnet = [{
    address_prefixes                              = ["10.10.2.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = azurerm_subnet_network_security_group_association.res-1.id
    name                                          = "SNET-ACCESS"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = azurerm_network_security_group.res-1.id
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
  }]
}
resource "azurerm_subnet" "res-1" {
  address_prefixes                = ["10.10.2.0/24"]
  default_outbound_access_enabled = false
  name                            = "SNET-ACCESS"
  resource_group_name             = azurerm_resource_group.res-1.name
  virtual_network_name            = "VNET-BATCH-HUB"
  depends_on = [
    azurerm_virtual_network.res-1,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-1" {
  network_security_group_id = azurerm_network_security_group.res-1.id
  subnet_id                 = azurerm_subnet.res-1.id
}
resource "azurerm_virtual_network_peering" "res-1" {
  allow_forwarded_traffic   = true
  name                      = "HUB-TO-QUALITY"
  remote_virtual_network_id = azurerm_virtual_network.res-2.id
  resource_group_name       = azurerm_resource_group.res-1.name
  virtual_network_name      = "VNET-BATCH-HUB"
  depends_on = [
    azurerm_virtual_network.res-1,
  ]
}
resource "azurerm_virtual_network_peering" "res-2" {
  allow_forwarded_traffic   = true
  name                      = "HUB-TO-WAREHOUSE"
  remote_virtual_network_id = azurerm_virtual_network.res-3.id
  resource_group_name       = azurerm_resource_group.res-1.name
  virtual_network_name      = "VNET-BATCH-HUB"
  depends_on = [
    azurerm_virtual_network.res-1,
  ]
}
resource "azurerm_virtual_network" "res-2" {
  address_space       = ["10.20.0.0/16"]
  location            = "spaincentral"
  name                = "VNET-BATCH-QUALITY"
  resource_group_name = azurerm_resource_group.res-1.name
  subnet = [{
    address_prefixes                              = ["10.20.1.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-QUALITY/subnets/SNET-QUALITY"
    name                                          = "SNET-QUALITY"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = azurerm_route_table.res-1.id
    security_group                                = azurerm_network_security_group.res-3.id
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
    }, {
    address_prefixes                              = ["10.20.2.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = azurerm_subnet_network_security_group_association.res-2.id
    name                                          = "SNET-PRIVATE-ENDPOINT"
    private_endpoint_network_policies             = "NetworkSecurityGroupEnabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = azurerm_network_security_group.res-2.id
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
  }]
  depends_on = [
    # One of azurerm_subnet_network_security_group_association.res-3,azurerm_subnet_route_table_association.res-1 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_subnet" "res-2" {
  address_prefixes                  = ["10.20.2.0/24"]
  default_outbound_access_enabled   = false
  name                              = "SNET-PRIVATE-ENDPOINT"
  private_endpoint_network_policies = "NetworkSecurityGroupEnabled"
  resource_group_name               = azurerm_resource_group.res-1.name
  virtual_network_name              = "VNET-BATCH-QUALITY"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-2" {
  network_security_group_id = azurerm_network_security_group.res-2.id
  subnet_id                 = azurerm_subnet.res-2.id
}
resource "azurerm_subnet" "res-3" {
  address_prefixes                = ["10.20.1.0/24"]
  default_outbound_access_enabled = false
  name                            = "SNET-QUALITY"
  resource_group_name             = azurerm_resource_group.res-1.name
  virtual_network_name            = "VNET-BATCH-QUALITY"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-3" {
  network_security_group_id = azurerm_network_security_group.res-3.id
  subnet_id                 = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-QUALITY/subnets/SNET-QUALITY"
  depends_on = [
    azurerm_subnet.res-3,
    # One of azurerm_subnet.res-3,azurerm_subnet_route_table_association.res-1 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_subnet_route_table_association" "res-1" {
  route_table_id = azurerm_route_table.res-1.id
  subnet_id      = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-QUALITY/subnets/SNET-QUALITY"
  depends_on = [
    azurerm_subnet.res-3,
    # One of azurerm_subnet.res-3,azurerm_subnet_network_security_group_association.res-3 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_virtual_network_peering" "res-3" {
  allow_forwarded_traffic   = true
  name                      = "QUALITY-TO-HUB"
  remote_virtual_network_id = azurerm_virtual_network.res-1.id
  resource_group_name       = azurerm_resource_group.res-1.name
  virtual_network_name      = "VNET-BATCH-QUALITY"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
resource "azurerm_virtual_network" "res-3" {
  address_space       = ["10.30.0.0/16"]
  location            = "spaincentral"
  name                = "VNET-BATCH-WAREHOUSE"
  resource_group_name = azurerm_resource_group.res-1.name
  subnet = [{
    address_prefixes                              = ["10.30.1.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-WAREHOUSE/subnets/SNET-WAREHOUSE"
    name                                          = "SNET-WAREHOUSE"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = azurerm_route_table.res-1.id
    security_group                                = azurerm_network_security_group.res-4.id
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
  }]
  depends_on = [
    # One of azurerm_subnet_network_security_group_association.res-4,azurerm_subnet_route_table_association.res-2 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_subnet" "res-4" {
  address_prefixes                = ["10.30.1.0/24"]
  default_outbound_access_enabled = false
  name                            = "SNET-WAREHOUSE"
  resource_group_name             = azurerm_resource_group.res-1.name
  virtual_network_name            = "VNET-BATCH-WAREHOUSE"
  depends_on = [
    azurerm_virtual_network.res-3,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-4" {
  network_security_group_id = azurerm_network_security_group.res-4.id
  subnet_id                 = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-WAREHOUSE/subnets/SNET-WAREHOUSE"
  depends_on = [
    azurerm_subnet.res-4,
    # One of azurerm_subnet.res-4,azurerm_subnet_route_table_association.res-2 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_subnet_route_table_association" "res-2" {
  route_table_id = azurerm_route_table.res-1.id
  subnet_id      = "/subscriptions/043a28c8-cdc9-469b-94e7-fcbc923c3602/resourceGroups/RG-PROJ-1/providers/Microsoft.Network/virtualNetworks/VNET-BATCH-WAREHOUSE/subnets/SNET-WAREHOUSE"
  depends_on = [
    azurerm_subnet.res-4,
    # One of azurerm_subnet.res-4,azurerm_subnet_network_security_group_association.res-4 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_virtual_network_peering" "res-4" {
  allow_forwarded_traffic   = true
  name                      = "WAREHOUSE-TO-HUB"
  remote_virtual_network_id = azurerm_virtual_network.res-1.id
  resource_group_name       = azurerm_resource_group.res-1.name
  virtual_network_name      = "VNET-BATCH-WAREHOUSE"
  depends_on = [
    azurerm_virtual_network.res-3,
  ]
}
resource "azurerm_storage_account" "res-1" {
  access_tier                     = "Hot"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  default_to_oauth_authentication = true
  location                        = "spaincentral"
  name                            = "batchstorage007"
  public_network_access_enabled   = false
  resource_group_name             = azurerm_resource_group.res-1.name
  shared_access_key_enabled       = false
  blob_properties {
    container_delete_retention_policy {
    }
    delete_retention_policy {
    }
  }
  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Deny"
  }
  share_properties {
    retention_policy {
    }
  }
}
resource "azurerm_storage_container" "res-1" {
  default_encryption_scope = "$account-encryption-key"
  name                     = "release-records"
  storage_account_id       = azurerm_storage_account.res-1.id
}
resource "azurerm_private_dns_a_record" "res-1" {
  name                = "batchstorage007"
  records             = ["10.20.2.4"]
  resource_group_name = "rg-proj-1"
  tags = {
    creator = "created by private endpoint pe-batch-blob with resource guid 5b815352-4e1b-4b16-9630-70c06370bd84"
  }
  ttl       = 10
  zone_name = "privatelink.blob.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.res-1,
  ]
}
