# Chapter 3 Labs — OCI Chart Registries, Cosign v3 & Kustomize Overlays

* `01-argocd-oci-repo-secret.yaml` — Declarative Argo CD OCI repository
  credential template (`type: helm`, `enableOCI: "true"`).
* `02-argocd-oci-digest-app.yaml` — Multi-source Argo CD `Application`
  pinning `orderflow-service` at an immutable `@sha256:` OCI digest.
* `03-cosign-verify-workflow.yaml` — CI workflow signing and verifying
  packaged Helm 4 OCI artifacts using Sigstore Cosign `v3.1.4` bundles.
* `kustomize/` — Kustomize `v5.8` Components, `helmCharts` inflator
  example, and `staging`/`prod` overlays for `OrderFlow`.
