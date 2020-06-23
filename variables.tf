variable "kubectl_namespace" {}

variable "helm_namespace" {}

variable "helm_repository" {}

variable "chart_version" {}

variable "dependencies" {
  type = "list"
}

variable "enable_azure_policy" {
  type    = string
  default = "0"
}

variable "values" {
  default = ""
  type    = "string"
}
