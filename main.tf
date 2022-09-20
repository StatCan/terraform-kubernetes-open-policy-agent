resource "helm_release" "gatekeeper" {
  name                = "gatekeeper"
  namespace           = var.namespace
  chart               = var.chart
  version             = var.chart_version
  timeout             = 1200
  repository          = var.helm_repository
  repository_username = var.helm_repository_username
  repository_password = var.helm_repository_password

  set {
    name  = "createNamespace"
    value = false
  }

  set {
    name  = "image.repository"
    value = "${var.image_hub}openpolicyagent/gatekeeper"
  }

  set {
    name  = "image.crdRepository"
    value = "${var.image_hub}openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "postInstall.labelNamespace.image.repository"
    value = "${var.image_hub}openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "preInstall.deleteWebhookConfigurations.image.repository"
    value = "${var.image_hub}openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "controllerManager.resources.limits.cpu"
    value = var.opa_limits_cpu
  }

  set {
    name  = "controllerManager.resources.limits.memory"
    value = var.opa_limits_memory
  }

  set {
    name  = "controllerManager.resources.requests.cpu"
    value = var.opa_requests_cpu
  }

  set {
    name  = "controllerManager.resources.requests.memory"
    value = var.opa_requests_memory
  }

  set {
    name  = "audit.resources.limits.cpu"
    value = var.opa_audit_limits_cpu
  }

  set {
    name  = "audit.resources.limits.memory"
    value = var.opa_audit_limits_memory
  }

  set {
    name  = "audit.resources.requests.cpu"
    value = var.opa_audit_requests_cpu
  }

  set {
    name  = "audit.resources.requests.memory"
    value = var.opa_audit_requests_memory
  }

  values = [
    <<EOF
image:
  pullSecrets: ${jsonencode(var.image_pull_secrets)}
EOF
    ,
    var.values
  ]
}
