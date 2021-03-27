terraform {
   backend "azurerm" {}
}
provider "azurerm" {
  version = "=2.5.0"
  features {}
}

 resource   "azurerm_virtual_network"   "myvnet"   { 
   name   =   "${var.env}-Vnet" 
   address_space   =   [ "10.0.0.0/16" ]
   location   =   var.location
   resource_group_name   =   var.resource_group_name
 } 

 resource   "azurerm_subnet"   "frontendsubnet"   { 
   name   =   "${var.env}-subnet"
   resource_group_name   =    var.resource_group_name 
   virtual_network_name   =   azurerm_virtual_network.myvnet.name 
   address_prefix   =   var.subnet
 } 

 resource   "azurerm_public_ip"   "myvm1publicip"   { 
   name   =   "${var.env}-pip" 
   location   =   var.location 
   resource_group_name   =   var.resource_group_name 
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 } 

 resource   "azurerm_network_interface"   "myvm1nic"   { 
   name   =   "${var.env}-nic" 
   location   =   var.location
   resource_group_name   =   var.resource_group_name 

   ip_configuration   { 
     name   =   "${var.env}-ipconfig1" 
     subnet_id   =   azurerm_subnet.frontendsubnet.id 
     private_ip_address_allocation   =   "Dynamic" 
     public_ip_address_id   =   azurerm_public_ip.myvm1publicip.id 
   } 
 } 

 resource   "azurerm_windows_virtual_machine"   "example"   { 
   name                    =   "${var.env}-vm1"   
   location                =   var.location 
   resource_group_name     =   var.resource_group_name 
   network_interface_ids   =   [ azurerm_network_interface.myvm1nic.id ] 
   size                    =   "Standard_B1s" 
   admin_username          =   "adminuser" 
   admin_password          =   "Password123!" 

   source_image_reference   { 
     publisher   =   "MicrosoftWindowsServer" 
     offer       =   "WindowsServer" 
     sku         =   "2019-Datacenter" 
     version     =   "latest" 
   } 

   os_disk   { 
     caching                =   "ReadWrite" 
     storage_account_type   ="Standard_LRS" 

   tags = {
     environment = "${var.env}"
  }

   
   } 
 }

  