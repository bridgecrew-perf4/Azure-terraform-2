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
} 

variable "subnet" {
type = string
} 

