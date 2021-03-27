variable "resource_group_name" {
   type = string
   description = "name of the resource group"
   default = "default-rg"
}

variable "location" {
 type = string
 description = "location"
 default = "westeurope"
}

variable "env" {
type = string
default = "tst"
} 

variable "vnetspace" {
type = string
default = "10.0.0.0/16"
} 

variable "subnet" {
type = string
default = "10.0.10.0/24"
} 

