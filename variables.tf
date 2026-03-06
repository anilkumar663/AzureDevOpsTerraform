variable "rgname" { 
  description = "Name of the resource group"
  type        = string
}

variable "location" { 
  description = "Location of the resource group"
  type        = string
}

variable "vnet" { 
  description = "Name of the virtual network"
  type        = string
}
variable "subnet" { 
  description = "Name of the subnet"
  type        = string
}
variable "nic" { 
  description = "Name of the network interface"
  type        = string
}
variable "vm" { 
  description = "Name of the virtual machine"
  type        = string
}