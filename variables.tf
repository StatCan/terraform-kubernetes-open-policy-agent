variable "namespace" {
  default = "gatekeeper-system"
}

variable "helm_repository" {
  default = "https://open-policy-agent.github.io/gatekeeper/charts"
}

variable "helm_repository_password" {
  default = ""
}

variable "helm_repository_username" {
  default = ""
}

variable "chart" {
  default = "gatekeeper"
}

variable "chart_version" {
  default = "3.8.1"
}

variable "values" {
  default = ""
  type    = string
}

variable "replicas" {
  default = "3"
  type    = string
}

variable "opa_limits_cpu" {
  default = "1000m"
  type    = string
}

variable "opa_limits_memory" {
  default = "512Mi"
  type    = string
}

variable "opa_requests_cpu" {
  default = "100m"
  type    = string
}

variable "opa_requests_memory" {
  default = "256Mi"
  type    = string
}

variable "image_hub" {
  default     = "docker.io/"
  type        = string
  description = "The name of the hub from which images will be pulled (with trailing slash)."
}

variable "image_pull_secrets" {
  type        = list(map(any))
  default     = []
  description = "The names of the ImagePullSecrets that the ServiceAccount will have access to."
}
variable "opa_audit_limits_cpu" {
  default = "1000m"
  type    = string
}

variable "opa_audit_limits_memory" {
  default = "512Mi"
  type    = string
}

variable "opa_audit_requests_cpu" {
  default = "100m"
  type    = string
}

variable "opa_audit_requests_memory" {
  default = "256Mi"
  type    = string
}
