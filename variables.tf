## This file will be used to provide the type, and a description of each variable

variable "resource_group_name" {
  type = string
  description = "The name for our resource group"
}

variable "location" {
  type        = string
  description = "The location of our Azure resources"
}
