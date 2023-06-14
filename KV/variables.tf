variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "location" {
  type        = string
  description = "RG location in Azure"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name in Azure"
}

variable "secret_names" {
  description = "Create Secret Names"
  type        = list(string)
}

variable "secret_values" {
  description = "Create Secret VALUES"
  type        = list(string)
}

variable keyvaultloop {
    type = list(string)
    default = ["keyvaulttemplategopi","keyvaulttemplategopi"]
}

variable rgloop {
    type = list(string)
    default = ["testrgkvgopi","testrgkvgopi"]
}
