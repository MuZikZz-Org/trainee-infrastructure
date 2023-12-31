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


variable "env_tags" {
  description = "Additional environment tags"
  type        = map(string)
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


