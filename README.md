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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0.0, < 3.0.0 |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_match_kind_only"></a> [audit\_match\_kind\_only](#input\_audit\_match\_kind\_only) | Only check resources of the kinds specified in all constraints defined in the cluster. | `bool` | `true` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | n/a | `string` | `"gatekeeper"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | n/a | `string` | `"3.12.0"` | no |
| <a name="input_exempt_namespaces"></a> [exempt\_namespaces](#input\_exempt\_namespaces) | The namespaces for which policies should not apply. | `list(string)` | `[]` | no |
| <a name="input_helm_repository"></a> [helm\_repository](#input\_helm\_repository) | The repository where the Helm chart is stored | `string` | `"https://open-policy-agent.github.io/gatekeeper/charts"` | no |
| <a name="input_helm_repository_password"></a> [helm\_repository\_password](#input\_helm\_repository\_password) | The password of the repository where the Helm chart is stored | `string` | `""` | no |
| <a name="input_helm_repository_username"></a> [helm\_repository\_username](#input\_helm\_repository\_username) | The username of the repository where the Helm chart is stored | `string` | `""` | no |
| <a name="input_image_hub"></a> [image\_hub](#input\_image\_hub) | The name of the hub from which images will be pulled (with trailing slash). | `string` | `"docker.io/"` | no |
| <a name="input_image_pull_secrets"></a> [image\_pull\_secrets](#input\_image\_pull\_secrets) | The names of the ImagePullSecrets that the ServiceAccount will have access to. | `list(map(any))` | `[]` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The log level for all components. | `string` | `"WARNING"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | `"gatekeeper-system"` | no |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | The nodeSelectors to apply to all components. | `map(string)` | <pre>{<br>  "kubernetes.io/os": "linux"<br>}</pre> | no |
| <a name="input_opa_audit_limits_cpu"></a> [opa\_audit\_limits\_cpu](#input\_opa\_audit\_limits\_cpu) | n/a | `string` | `"1000m"` | no |
| <a name="input_opa_audit_limits_memory"></a> [opa\_audit\_limits\_memory](#input\_opa\_audit\_limits\_memory) | n/a | `string` | `"512Mi"` | no |
| <a name="input_opa_audit_requests_cpu"></a> [opa\_audit\_requests\_cpu](#input\_opa\_audit\_requests\_cpu) | n/a | `string` | `"100m"` | no |
| <a name="input_opa_audit_requests_memory"></a> [opa\_audit\_requests\_memory](#input\_opa\_audit\_requests\_memory) | n/a | `string` | `"256Mi"` | no |
| <a name="input_opa_limits_cpu"></a> [opa\_limits\_cpu](#input\_opa\_limits\_cpu) | n/a | `string` | `"1000m"` | no |
| <a name="input_opa_limits_memory"></a> [opa\_limits\_memory](#input\_opa\_limits\_memory) | n/a | `string` | `"512Mi"` | no |
| <a name="input_opa_requests_cpu"></a> [opa\_requests\_cpu](#input\_opa\_requests\_cpu) | n/a | `string` | `"100m"` | no |
| <a name="input_opa_requests_memory"></a> [opa\_requests\_memory](#input\_opa\_requests\_memory) | n/a | `string` | `"256Mi"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | n/a | `string` | `"3"` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | The tolerations to set on all components. | <pre>list(object({<br>    effect             = optional(string)<br>    key                = optional(string)<br>    operator           = optional(string)<br>    toleration_seconds = optional(number)<br>    value              = optional(string)<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | n/a | `string` | `""` | no |


<!-- END_TF_DOCS -->
## Usage

```terraform
module "helm_gatekeeper" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git?ref=v4.2.1"

  chart_version = "3.8.1"
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

## History

| Date       | Release | Change                                                         |
| ---------- | ------- | -------------------------------------------------------------- |
| 2023-06-05 | v4.3.0  | Update to chart 3.12.0 and add node selectors and tolerations. |  |
| 2023-02-03 | v4.2.1  | Specify sensitive variables                                    |
| 2022-11-21 | v4.2.0  | Add replicas variable                                          |
| 2022-09-20 | v4.1.1  | Ensure jobs get the proper image repository                    |
| 2022-05-18 | v4.1.0  | Update to Gatekeeper 3.8.1                                     |
| 2021-10-05 | v4.0.0  | Switch to Helm for GateKeeper installation                     |
| 2021-09-25 | v3.0.0  | Update module for Terraform v0.13                              |
| 2020-02-08 | v2.2.0  | Update to Gatekeeper 3.3.0                                     |
| 2020-12-17 | v2.1.1  | Paramaterize OPA Audit limits.                                 |
| 2020-08-24 | v2.1.0  | Upgrade OPA to v3.2.0, changes to terraform                    |
| 2020-08-24 | v2.0.3  | Upgrade OPA to v3.1.0-rc1                                      |
| 2020-08-24 | v2.0.2  | Paramaterize OPA                                               |
| 2020-08-24 | v2.0.1  | Paramaterize OPA                                               |
| 2020-06-23 | v2.0.0  | Minor modifications to submodule for Helm 3                    |
--
