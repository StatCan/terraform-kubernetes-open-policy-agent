# Terraform Kubernetes Open Policy Agent

## Introduction

This module deploys and configures Open Policy Agent inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

- TBD

## Dependencies

- Terraform v0.13+

## Optional (depending on options configured)

- None

## Usage

```terraform
module "helm_gatekeeper" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git?ref=v4.0.0"

  chart_version = "3.6.0"
  depends_on = [
    module.namespace_gatekeeper_system,
  ]

  helm_repository          = "https://artifactory.cloud.statcan.ca/artifactory/helm-opa-remote"
  helm_repository_password = var.docker_password
  helm_repository_username = var.docker_username

  namespace = kubernetes_namespace.gatekeeper_system.id
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

  values = <<EOF
auditChunkSize: 500
auditMatchKindOnly: true

logLevel: WARNING
EOF
}
```

## Variables Values

| Name                      | Type   | Required | Value                                                                         |
| ------------------------- | ------ | -------- | ----------------------------------------------------------------------------- |
| image_hub                 | string | no       | Allows to set the hub from which images will be pulled                        |
| image_pull_secrets        | list   | no       | The names of the ImagePullSecrets that the ServiceAccount will have access to |
| helm_repository           | string | yes      | The repository from which to download the chart                               |
| helm_namespace            | string | yes      | The namespace in which to install the chart                                   |
| chart_version             | string | yes      | The version of the Azure Policy helm chart                                    |
| opa_limits_cpu            | string | no       | The CPU limits to set for the OPA containers                                  |
| opa_limits_memory         | string | no       | The memory limits to set for the OPA containers                               |
| opa_requests_cpu          | string | no       | The CPU requests to set for the OPA containers                                |
| opa_requests_memory       | string | no       | The meory requests to set for the OPA containers                              |
| opa_audit_limits_cpu      | string | no       | The CPU limits to set for the OPA audit containers                            |
| opa_audit_limits_memory   | string | no       | The memory limits to set for the OPA audit containers                         |
| opa_audit_requests_cpu    | string | no       | The CPU requests to set for the OPA audit containers                          |
| opa_audit_requests_memory | string | no       | The meory requests to set for the OPA audit containers                        |
| values                    | string | no       | The values to pass to the Azure Policy chart                                  |

## History

| Date     | Release | Change                                                                        |
| -------- | ------- | ----------------------------------------------------------------------------- |
| 20211005 | v4.0.0  | Switch to Helm for GateKeeper installation                                    |
| 20210925 | v3.0.0  | Update module for Terraform v0.13                                             |
| 20200208 | v2.2.0  | Update to Gatekeeper 3.3.0                                                    |
| 20201217 | v2.1.1  | Paramaterize OPA Audit limits.                                                |
| 20200824 | v2.1.0  | Upgrade OPA to v3.2.0, changes to how terraform is configured, update README. |
| 20200824 | v2.0.3  | Upgrade OPA to v3.1.0-rc1                                                     |
| 20200824 | v2.0.2  | Paramaterize OPA                                                              |
| 20200824 | v2.0.1  | Paramaterize OPA                                                              |
| 20200623 | v2.0.0  | Minor modifications to submodule for Helm 3                                   |
