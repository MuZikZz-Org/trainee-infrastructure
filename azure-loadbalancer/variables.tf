######################################################################
#                               COMMON
######################################################################
variable "tenant_id" {}
variable "subscription_id" {}
variable "management_subscription_info" {}
variable "connectivity_subscription_info" {}
variable "security_subscription_info" {}
variable "vnet" {}
variable "subnet" {}
variable "kubernetes" {}
variable "log" {}

######################################################################
#                               CUSTOM
######################################################################

variable "network_access_key" {}
variable "network_access_secretkey" {}
variable "workload_access_key" {}
variable "workload_access_secretkey" {}
variable "common_tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {
    Provisioner = "terraform"
    TFModule    = "create-azure-agic"
  }
}

variable "custom_subnet_name" {
  description = "Specific Custom Subnet"
  default     = "ApplicationGatewaySubnet"
  type        = string
}

variable "custom_workload_resource_group_name" {
  description = "Specific Workload Resource Group"
  type        = string
}

variable "lb_type" {
  description = "Azure loadbalancer type"
  type        = string
}

variable "frontend_private_ip_address_allocation" {
  description = "Azure loadbalancer frontend private IP address allocation"
  type        = string
}

variable "frontend_private_ip_address" {
  description = "Azure loadbalancer frontend private IP address"
  type        = string
}

variable "lb_sku_name" {
  description = "Azure loadbalancer SKU name"
  type        = string
}

variable "env_tags" {}