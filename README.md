# OrderFlow GitOps Delivery — Companion Code Labs

Companion Helm 4 charts, Argo CD v3.6 manifests, OCI/Cosign supply-chain
pipelines, Kustomize overlays, ApplicationSets, Source Hydrator examples,
External Secrets Operator v1 configs, Argo Rollouts Gateway API canary
specs, and Kargo v1.12 promotion pipelines for:

> **GitOps with Argo CD and Helm: A Practical Guide to Modern Helm 4,
> OCI Artifacts, Multi-Cluster ApplicationSets, Progressive Delivery, and
> Secret-Free Repositories**  
> *Practical Engineering Series — Volume 03*  
> **Author & Publisher:** Kien Nguyen  
> **Repository:** `https://github.com/kiennt308/gitops-argocd-helm-labs`

Copyright © 2026 Kien Nguyen. Companion Helm charts, Kubernetes and
GitOps YAML manifests, policy configurations, and test suites in this
repository are licensed under the **Apache License, Version 2.0
(Apache-2.0)**.

---

## Verified Software Baseline (`Nov. 19, 2026`)

| Tool / Component | Verified Version | Purpose in Labs |
|---|---|---|
| **OpenGitOps Spec** | `v1.0.0` (CNCF) | Pull-based reconciliation model |
| **Kubernetes / K3s** | `v1.35 – v1.37` (`v1.37.2+k3s1`) | Live PSA-restricted validation |
| **Argo CD** | `v3.6.2` (`v3.6.x`) | Annotation tracking, SSA, Hydrator |
| **Helm** | `v4.3.2` (`v4.3.x`) | SSA default, `kstatus`, OCI digests |
| **Argo Rollouts** | `v1.10.2` (`v1.10.x`) | Canary, Blue-Green, Analysis |
| **Gateway API Plugin** | `v0.17.0` (Gateway API `v1.6`) | `HTTPRoute` canary & `pingPong` |
| **Kargo (Akuity)** | `v1.12.6` | `Warehouse`, `Freight`, `Stage` |
| **Image Updater** | `v1.5.0` | Automated tag tracking baseline |
| **External Secrets** | `v2.15.0` (`external-secrets.io/v1`) | Pull-based secret sync (GA) |
| **Sealed Secrets** | `v0.41.2` (`bitnami/sealed-secrets`) | Air-gapped encrypted secrets |
| **SOPS / Kustomize** | `v3.13.3` / `v5.8.3` | Field encryption & overlays |
| **helm-unittest** | `v1.2.1` | Clusterless Helm template tests |
| **kubeconform / Cosign** | `v0.8.0` / `v3.1.4` | Schema checks & OCI signatures |

> **Retired Patterns Replaced:** `ingress-nginx` (EOL March 2026),
> `external-secrets.io/v1beta1`, `bitnami-labs/sealed-secrets`,
> root-path Source Hydrator configs, and `:latest` image tags are
> excluded from all charts and manifests.

---

## Repository Directory Map

```text
code-labs/
├── README.md                 Baseline versions & Docker test guide
├── charts/
│   ├── orderflow-lib/        Helm 4 library chart (PSA restricted)
│   └── orderflow-service/    App chart + values.schema.json + tests
├── ch01/                     Argo CD v3.6 CM, annotation tracking, SSA
├── ch02/                     Helm 4 service values & negative fixtures
├── ch03/                     OCI digests, Cosign v3, Kustomize overlays
├── ch04/                     Cluster secrets, Matrix & RollingSync
├── ch05/                     Source Hydrator, Sync Waves & ignoreDiffs
├── ch06/                     ESO v1, Sealed Secrets & SOPS configs
├── ch07/                     Gateway API HTTPRoute & Argo Rollouts
├── ch08/                     Kargo Warehouse/Stage & Image Updater
└── ch09/                     AppProjects, RBAC CSV, alerts & DR drill
```

---

## Zero-Cloud-Bill Validation (Docker)

Every Helm chart and Kubernetes manifest can be linted, unit-tested,
schema-checked, and dry-run against a disposable local K3s cluster
without cloud accounts or host kubeconfig edits:

```bash
docker run --rm -v "${PWD}:/work" -w /work/charts/orderflow-service \
  alpine/helm:latest dependency build

docker run --rm -v "${PWD}:/work" -w /work/charts/orderflow-service \
  alpine/helm:latest lint . --strict -f ../../ch02/values-order-service.yaml

docker run --rm -v "${PWD}:/work" -w /work/charts/orderflow-service \
  alpine/helm:latest template order-service . \
  -f ../../ch02/values-order-service.yaml
```

Pair local `helm template` output with `kubeconform` and `helm-unittest`
for fast pre-merge CI validation before deploying to a sandbox K3s
cluster.
