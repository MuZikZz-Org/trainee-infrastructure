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
variable "subnet" {
  description = "Subnet (Exiting in common-configs)"
}
variable "vnet" {
  description = "VNet (Exiting in common-configs)"
}
variable "az_location_name" {
  description = "Azure location Name (Exiting in common-configs)"
  type        = string
}
variable "vm_disk_encryption_set_id" {
  description = "Azure VM Disk Encryption set ID (Exiting in common-configs)"
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
variable "create_resource_group" {
  description = "Enable Create Resource Group"
  type = bool
  default = false
}
variable "custom_resource_group_name" {
  description = "Specific Resource Group Name"
  default     = ""
  type        = string
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
variable "vm_zone" {
  description = "Type of VM zone"
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
variable "storage_image_id" {
  description = "Window OS Base Image"
  type = string
}
variable "custom_subnet_name" {
  description = "Specific Custom Subnet"
  default     = ""
  type        = string
}
variable "patch_mode" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine"
  default     = ""
  type        = string
}


