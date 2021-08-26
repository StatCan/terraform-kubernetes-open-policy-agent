resource "local_file" "gatekeeper_template" {
  sensitive_content = templatefile("${path.module}/config/gatekeeper.yml", {
    opa_limits_cpu      = var.opa_limits_cpu
    opa_limits_memory   = var.opa_limits_memory
    opa_requests_cpu    = var.opa_requests_cpu
    opa_requests_memory = var.opa_requests_memory

    image_hub          = var.image_hub
    image_pull_secrets = var.image_pull_secrets

    opa_audit_limits_cpu      = var.opa_audit_limits_cpu
    opa_audit_limits_memory   = var.opa_audit_limits_memory
    opa_audit_requests_cpu    = var.opa_audit_requests_cpu
    opa_audit_requests_memory = var.opa_audit_requests_memory
  })

  filename = "${path.module}/gatekeeper.yml"
}

resource "null_resource" "gatekeeper_init" {
  triggers = {
    manifests = local_file.gatekeeper_template.sensitive_content
  }

  provisioner "local-exec" {
    command = "kubectl -n ${var.kubectl_namespace} apply -f ${local_file.gatekeeper_template.filename}"
  }
}

resource "null_resource" "azure_policy_gatekeeper_sync" {
  count = var.enable_azure_policy ? 1 : 0

  triggers = {
    hash = filesha256("${path.module}/config/azure/gatekeeper-opa-sync.yml")
  }

  provisioner "local-exec" {
    command = "kubectl -n ${var.kubectl_namespace} apply -f ${path.module}/config/azure/gatekeeper-opa-sync.yml"
  }
}

resource "helm_release" "azure_policy" {
  count = var.enable_azure_policy ? 1 : 0

  name       = "azure-policy"
  repository = var.helm_repository
  chart      = "azure-policy-addon-aks-engine"
  version    = var.chart_version
  namespace  = var.helm_namespace
  timeout    = 1200

  values = [
    var.values,
  ]

}
