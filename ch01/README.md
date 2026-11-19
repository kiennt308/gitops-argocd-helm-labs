# Chapter 1 Labs — Argo CD v3.6 Internals, Annotation Tracking & SSA

Files in this directory demonstrate modern Argo CD `v3.6.2` control-plane
configuration, annotation tracking (`argocd.argoproj.io/tracking-id`),
sharding configuration, and Server-Side Apply field-ownership rules.

* `01-argocd-cm-v36.yaml` — `argocd-cm` ConfigMap explicitly documenting
  Argo CD `v3.x` default `annotation` resource tracking and Source
  Hydrator toggle.
* `02-argocd-cmd-params-cm.yaml` — Controller/repo-server concurrency and
  timeout tuning (`argocd-cmd-params-cm`).
* `03-orderflow-staging-app.yaml` — Staging `Application` using
  `automated` self-healing sync and `ServerSideApply=true`.
* `04-orderflow-prod-app.yaml` — Production `Application` enforcing manual
  sync gating and `RespectIgnoreDifferences=true`.
* `05-ssa-field-ownership-demo.yaml` — Standalone PSA-restricted
  Deployment used to test live Kubernetes Server-Side Apply manager
  conflicts (`kubectl apply --server-side --field-manager=...`).

## Quick Validation

```bash
kubectl apply --dry-run=server -f 03-orderflow-staging-app.yaml
kubectl apply --server-side --field-manager=argocd-controller \
  -f 05-ssa-field-ownership-demo.yaml
```
