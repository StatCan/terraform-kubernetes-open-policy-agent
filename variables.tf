variable "kubectl_service_account" {}
variable "kubectl_namespace" {}

variable "helm_service_account" {}

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

variable "opa_limits_cpu" {
  default = "1000m"
  type    = "string"
}

variable "opa_limits_memory" {
  default = "512Mi"
  type    = "string"
}

variable "opa_requests_cpu" {
  default = "100m"
  type    = "string"
}

variable "opa_requests_memory" {
  default = "256Mi"
  type    = "string"
}
