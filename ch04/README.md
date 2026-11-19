# Chapter 4 Labs — Multi-Cluster ApplicationSets & Blast-Radius Control

* `01-clusters-secrets-template.yaml` — Declarative cluster inventory
  labels (`orderflow-staging-us-east-1`, `orderflow-prod-us-east-1`,
  `orderflow-prod-eu-west-1`).
* `02-appset-matrix-progressive.yaml` — `ApplicationSet` combining
  `git.files` + `clusters` in a `matrix` generator with `GoTemplate`,
  `RollingSync` stages, and `preserveResourcesOnDeletion: true`.
* `03-appset-git-files-staging.yaml` — Focused `ApplicationSet` using
  `git.files` for `orderflow-staging` services.
* `fleet-config/` — Declarative per-service JSON configuration consumed
  by the Matrix generator.
