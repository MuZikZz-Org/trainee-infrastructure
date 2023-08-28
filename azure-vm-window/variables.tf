######################################################################
#                               COMMON
######################################################################

variable "ARM_SUBSCRIPTION_ID" {
    description = "Azure Subscription ID (Exiting in common-configs)"
    type        = string
}

variable "ARM_TENANT_ID" {
    description = "Azure Tenant ID (Exiting in common-configs)"
    type        = string
}
variable "ARM_CLIENT_ID" {
    description = "Azure Client ID (Exiting in common-configs)"
    type        = string
}
variable "ARM_CLIENT_SECRET" {
    description = "Azure Client Secret (Exiting in common-configs)"
    type        = string
}

######################################################################
#                               CUSTOM
######################################################################

variable "SRC_IMG_REF_PUBLISHER" {}
variable "SRC_IMG_REF_OFFER" {}
variable "SRC_IMG_REF_SKU" {}
variable "SRC_IMG_REF_VERSION" {}
variable "workload_access_key" {
  description = "Workload Access Key (Exiting in common-configs - Need define in placeholder-config.json)"
  type        = string
}
variable "workload_access_secretkey" {
  description = "Workload Access SecretKey (Exiting in common-configs - Need define in placeholder-config.json)" 
  type        = string
}
variable "common_tags" {
  description = "Additional resource tags"
  type        = map(string)
  default     = {
    Provisioner = "terraform"
    TFModule    = "create-azure-resource-group"
  }
}
variable "env_tags" {
  description = "Additional environment tags"
  type        = map(string)
}
variable "custom_vm_name" {
  description = "Specific Virtual Machine Name"
  default     = ""
  type        = string
}
variable "instance_count" {
  description = "Number of VM instance"
  type = string
  default = "1"
}
variable "vm_size" {
  description = "Type of VM size"
  type = string
}
variable "os_admin_username" {
  description = "Window OS Admin Username"
  type = string
}
variable "os_admin_password" {
  description = "Window OS Admin Password"
  type = string
}


