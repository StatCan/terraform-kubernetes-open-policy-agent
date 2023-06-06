variable "namespace" {
  default = "gatekeeper-system"
}

variable "helm_repository" {
  default     = "https://open-policy-agent.github.io/gatekeeper/charts"
  description = "The repository where the Helm chart is stored"
}

variable "helm_repository_password" {
  type        = string
  nullable    = false
  default     = ""
  description = "The password of the repository where the Helm chart is stored"
  sensitive   = true
}

variable "helm_repository_username" {
  type        = string
  nullable    = false
  default     = ""
  description = "The username of the repository where the Helm chart is stored"
  sensitive   = true
}

variable "chart" {
  default = "gatekeeper"
}

variable "chart_version" {
  default = "3.12.0"
}

variable "values" {
  default = ""
  type    = string
}

variable "audit_match_kind_only" {
  description = "Only check resources of the kinds specified in all constraints defined in the cluster."
  type        = bool
  default     = true
  nullable    = false
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

variable "log_level" {
  description = "The log level for all components."
  type        = string
  default     = "WARNING"
  nullable    = false
}

variable "image_hub" {
  default     = "docker.io/"
  type        = string
  description = "The name of the hub from which images will be pulled (with trailing slash)."

  validation {
    condition     = endswith(var.image_hub, "/")
    error_message = "image_hub must end with a trailing slash"
  }
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

variable "exempt_namespaces" {
  description = "The namespaces for which policies should not apply."
  type        = list(string)
  default     = []
}

variable "node_selector" {
  type = map(string)
  default = {
    "kubernetes.io/os" = "linux"
  }

  description = "The nodeSelectors to apply to all components."
}

variable "tolerations" {
  description = "The tolerations to set on all components."
  type = list(object({
    effect             = optional(string)
    key                = optional(string)
    operator           = optional(string)
    toleration_seconds = optional(number)
    value              = optional(string)
    })
  )
  default = []

  validation {
    condition     = alltrue([for t in var.tolerations : t.effect == null ? true : contains(["", "NoSchedule", "PreferNoSchedule", "NoExecute"], t.effect)])
    error_message = "Valid effects are one of: [null, \"\", NoSchedule, PreferNoSchedule, NoExecute]"
  }

  validation {
    condition     = alltrue([for t in var.tolerations : t.operator == null ? true : contains(["", "Equals", "Exists"], t.operator)])
    error_message = "Valid operators are Exists and Equal."
  }

  validation {
    condition     = alltrue([for t in var.tolerations : (t.key == "" || t.key == null) ? t.operator == "Exists" : true])
    error_message = "If key is empty, operator must be Exists."
  }

  validation {
    condition     = alltrue([for t in var.tolerations : t.operator == "Exists" ? t.value == "" || t.value == null : true])
    error_message = "If the operator is Exists, the value should be empty, otherwise just a regular string."
  }
}
