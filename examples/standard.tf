module "helm_gatekeeper" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git?ref=v4.3.0"

  depends_on = [
    module.namespace_gatekeeper_system,
  ]

  helm_repository          = "https://artifactory.cloud.statcan.ca/artifactory/helm-opa-remote"
  helm_repository_password = var.docker_password
  helm_repository_username = var.docker_username

  namespace = kubernetes_namespace.gatekeeper_system.metadata[0].namespace

  image_hub = "artifactory.cloud.statcan.ca/docker-remote/"
  image_pull_secrets = [{
    name = "artifactory-prod"
  }]

  opa_limits_cpu      = "500m"
  opa_limits_memory   = "2048Mi"
  opa_requests_cpu    = "100m"
  opa_requests_memory = "1024Mi"

  opa_audit_limits_cpu      = "500m"
  opa_audit_limits_memory   = "2048Mi"
  opa_audit_requests_cpu    = "100m"
  opa_audit_requests_memory = "1024Mi"

  # Extra configurations to define.
  values = ""
}
