# Terraform Kubernetes Open Policy Agent

## Introduction

This module deploys and configures Open Policy Agent inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* Terraform v0.13+

## Optional (depending on options configured):

* None

## Usage

```terraform
module "kubectl_opa" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git?ref=v3.0.0"

  depends_on = [
    module.namespace_gatekeeper_system,
  ]

  kubectl_namespace   = module.namespace_gatekeeper_system.name
  chart_version       = "0.1.0"
  helm_namespace      = module.namespace_gatekeeper_system.name
  helm_repository     = "azure-policy"

  enable_azure_policy = 0
  values              = <<EOF

EOF
}
```

## Variables Values

| Name                      | Type   | Required | Value                                                                         |
| ------------------------- | ------ | -------- | ----------------------------------------------------------------------------- |
| kubectl_namespace         | list   | yes      | The namespace kubectl will install the manifests under                        |
| image_hub                 | string | no       | Allows to set the hub from which images will be pulled                        |
| image_pull_secrets        | list   | no       | The names of the ImagePullSecrets that the ServiceAccount will have access to |
| enable_azure_policy       | string | yes      | Whether to install the Azure Policy helm chart                                |
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
| 20200623 | v2.0.0  | Minor modifications to submodule for Helm 3                                   |
| 20200824 | v2.0.1  | Paramaterize OPA                                                              |
| 20200824 | v2.0.2  | Paramaterize OPA                                                              |
| 20200824 | v2.0.3  | Upgrade OPA to v3.1.0-rc1                                                     |
| 20200824 | v2.1.0  | Upgrade OPA to v3.2.0, changes to how terraform is configured, update README. |
| 20201217 | v2.1.1  | Paramaterize OPA Audit limits.                                                |
| 20200208 | v2.2.0  | Update to Gatekeeper v3.3.0                                                   |
| 20210925 | v3.0.0  | Update module for Terraform v0.13                                             |
