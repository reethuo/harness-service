terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.14.0"
    }
  }
}

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "ucHySz2jQKKWQweZdXyCog"
  platform_api_key = "your_platform_api_key_here"
}

resource "harness_platform_service" "this" {
  identifier  = "example-service"
  name        = "example-service"
  org_id      = "default"
  project_id  = "MyProject"
  description = "Created by Terraform"

  yaml = <<-EOT
    service:
      name: example-service
      identifier: example-service
      orgIdentifier: default
      projectIdentifier: MyProject
      serviceDefinition:
        type: Kubernetes
        spec:
          manifests:
            - manifest:
                identifier: manifest1
                type: K8sManifest
                spec:
                  store:
                    type: Github
                    spec:
                      connectorRef: account.GithubConnector
                      gitFetchType: Branch
                      branch: main
                      repoName: example-repo
                      paths:
                        - k8s/manifest.yaml
                  skipResourceVersioning: false
  EOT
}
