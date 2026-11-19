# Chapter 8 Labs — Stage Promotion with Kargo v1.12 & Image Updater

* `01-kargo-project.yaml` — Kargo `Project` (`orderflow`) defining
  promotion authorization boundaries.
* `02-kargo-warehouse.yaml` — `Warehouse` watching OCI container images,
  Helm 4 OCI charts, and Git configuration commits.
* `03-kargo-stage-staging.yaml` — Automated `staging` `Stage` with
  promotion steps and `AnalysisTemplate` verification.
* `04-kargo-stage-prod.yaml` — Gated `prod` `Stage` consuming only
  verified `staging` Freight and opening a peer-reviewed Git PR.
* `05-image-updater-staging-app.yaml` — Lightweight
  `argocd-image-updater v1.5.0` annotation pattern for dev/sandbox apps.
