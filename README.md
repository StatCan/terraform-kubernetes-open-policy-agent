# Terraform Kubernetes Open Policy Agent

## Introduction

This module deploys and configures Open Policy Agent inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Usage

```terraform
module "kubectl_opa" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-kubernetes-open-policy-agent.git?ref=v2.0.3"

  dependencies = [
    "${module.namespace_gatekeeper_system.depended_on}",
  ]

  kubectl_namespace       = "${module.namespace_gatekeeper_system.name}"

  chart_version = "0.1.0"

  helm_namespace       = "${module.namespace_gatekeeper_system.name}"
  helm_repository      = "azure-policy"

  enable_azure_policy = 0
  values              = <<EOF

EOF
}
```

## Variables Values

| Name                | Type   | Required | Value                                                  |
| ------------------- | ------ | -------- | ------------------------------------------------------ |
| dependencies        | list   | yes      | Dependency name refering to namespace module           |
| kubectl_namespace   | list   | yes      | The namespace kubectl will install the manifests under |
| enable_azure_policy | string | yes      | Whether to install the Azure Policy helm chart         |
| helm_repository     | string | yes      | The repository from which to download the chart        |
| helm_namespace      | string | yes      | The namespace in which to install the chart            |
| chart_version       | string | yes      | The version of the Azure Policy helm chart             |
| values              | string | no       | The values to pass to the Azure Policy chart           |

## History

| Date     | Release    | Change                                       |
| -------- | ---------- | -------------------------------------------- |
| 20200623 | v2.0.0     | Minor modifications to submodule for Helm 3  |
| 20200824 | v2.0.1     | Paramaterize OPA                             |
| 20200824 | v2.0.2     | Paramaterize OPA                             |
| 20200824 | v2.0.3     | Upgrade OPA to v3.1.0-rc1                    |
