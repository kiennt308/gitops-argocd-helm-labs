# Chapter 9 Labs — GitOps Security, Observability & Disaster Recovery

* `01-appproject-orderflow-apps.yaml` — Multi-tenant `AppProject`
  restricting repos, namespaces, and cluster-wide resource mutations.
* `02-appproject-platform-core.yaml` — Platform-team `AppProject` scoped
  to control-plane addons (`argocd`, `argo-rollouts`, `external-secrets`).
* `03-argocd-rbac-cm.yaml` — Zero-trust OIDC group RBAC CSV policies.
* `04-repo-server-hardening-patch.yaml` — PSA-compliant container and
  plugin hardening for `argocd-repo-server`.
* `05-argocd-servicemonitor-alerts.yaml` — Prometheus `ServiceMonitor`
  and `PrometheusRule` alerts for reconciliation health and rate limits.
* `06-dr-export-verify.sh` — Control-plane backup (`argocd admin export`)
  and verification script.
