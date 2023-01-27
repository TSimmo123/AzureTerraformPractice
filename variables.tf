## This file will be used to provide the type, and a description of each variable

variable "rg_name" {
  type        = string
  description = "The name for our resource group"
}

variable "location" {
  type        = string
  description = "The location of our Azure resources"
}

variable "nsg_name" {
  type        = string
  description = "The name for our Network Security Group"
}

variable "vnet_name" {
  type        = string
  description = "The name for our Virtual Network"
}

variable "subnet1_name" {
  type        = string
  description = "The name of our first subnet"
}

variable "subnet2_name" {
  type        = string
  description = "The name of our second subnet"
}

#variable "vm1_name" {
#  type        = string
#  description = "The name for our first VM"
#}

#variable "vm2_name" {
#  type        = string
#  description = "The name for our second VM"
#}
