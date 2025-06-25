variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "rt-stock-rg"
}

variable "eventhub_namespace" {
  default = "rtstocknamespace"
}

variable "eventhub_name" {
  default = "rtstockhub"
}

variable "storage_account_name" {
  default = "rtstockadls123" # must be globally unique!
}
