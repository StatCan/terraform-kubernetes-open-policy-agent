variable "kubectl_service_account" {}
variable "kubectl_namespace" {}

variable "dependencies" {
  type = "list"
}

variable "enable_azure_policy" {
  type = string
  default = "0"
}
