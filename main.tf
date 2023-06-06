locals {
  # The values for gatekeeper that are set by the provider.
  # Set in a local to take advantage of the IDEs understanding of terraform structure for proper indentation verification.
  values = {
    replicas = var.replicas,
    image = {
      pullSecrets = var.image_pull_secrets,
    }
    postUpgrade = {
      labelNamespace = {
        image = {
          pullSecrets = var.image_pull_secrets
        }
      }
      nodeSelector = var.node_selector
      tolerations  = var.tolerations
    }
    postInstall = {
      labelNamespace = {
        image = {
          pullSecrets = var.image_pull_secrets
        }
      }
      nodeSelector = var.node_selector
      tolerations  = var.tolerations
    }
    preUninstall = {
      deleteWebhookConfigurations = {
        image = {
          pullSecrets = var.image_pull_secrets
        }
      }
      nodeSelector = var.node_selector
      tolerations  = var.tolerations
    }
    controllerManager = {
      exemptNamespaces = var.exempt_namespaces
      nodeSelector     = var.node_selector
      tolerations      = var.tolerations
    }
    audit = {
      nodeSelector = var.node_selector
      tolerations  = var.tolerations
    }
    crds = {
      nodeSelector = var.node_selector
      tolerations  = var.tolerations
    }
  }
}

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
    name  = "auditMatchKindOnly"
    value = var.audit_match_kind_only
  }

  set {
    name  = "logLevel"
    value = var.log_level
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
    name  = "postUpgrade.labelNamespace.image.repository "
    value = "${var.image_hub}openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "postInstall.labelNamespace.image.repository"
    value = "${var.image_hub}openpolicyagent/gatekeeper-crds"
  }

  set {
    name  = "postInstall.probeWebhook.image.repository"
    value = "${var.image_hub}curlimages/curl"
  }

  set {
    name  = "preUninstall.deleteWebhookConfigurations.image.repository"
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

  values = [yamlencode(local.values), var.values]
}
