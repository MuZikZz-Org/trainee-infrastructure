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

variable "PUBLIC_IP" {
  description = "Public IP address for SonarQube"
  type        = string
}
variable "SONARQUBE_PORT" {
  description = "Port for SonarQube"
  type        = number
}
variable "env_tags" {
    description = "Tags (Specific to the resource)"
    type        = map(string)
}
# variable "resource_group_location" {
#   description = "Location of resource group."
#   type        = string
# }
