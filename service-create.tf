terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "0.14.0"
    }
  }
  # required_version = "1.3.9"
}

resource "harness_platform_service" "this" {
  identifier   = "git-trigger-terraform-service"
  name         = "git-trigger-terraform-service"
  org_id       = "default"
  project_id   = "SFTY_Training"
  description  =  "adding description"
  yaml         = <<-EOH
service:
  name: git-trigger-terraform-service
  identifier: git-trigger-terraform-service
  orgIdentifier: default
  projectIdentifier: SFTY_Training
  serviceDefinition:
    spec:
      manifests:
        - manifest:
            identifier: manifest1
            type: K8sManifest
            spec:
              store:
                type: Github
                spec:
                  connectorRef: <+input>
                  gitFetchType: Branch
                  paths:
                    - infra-vm.tf
                  repoName: tera0
                  branch: main
              skipResourceVersioning: false
      /* artifacts:
        primary:
          primaryArtifactRef: <+input>
          sources:
            - spec:
                connectorRef: rajharnessdev
                imagePath: harnessdev/rajtodoapp
                tag: "4"
                digest: ""
              identifier: todofrompipeline
              type: DockerRegistry */
    type: Kubernetes
  EOH
}

/* output "out" {
  value = harness_platform_service.this.id
} */

provider "harness" {
  endpoint         = "https://app.harness.io/gateway"
  account_id       = "ucHySz2jQKKWQweZdXyCog"
  platform_api_key = ""
}
