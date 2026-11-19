# Chapter 6 Labs — Secret-Free GitOps Repositories

All manifests here keep plaintext Kubernetes `Secret` objects out of Git:

* `01-cluster-secret-store-aws.yaml` — `external-secrets.io/v1` (GA)
  `ClusterSecretStore` bound to AWS Secrets Manager via EKS Pod Identity.
* `02-external-secret-order-service.yaml` — `ExternalSecret` (`v1`)
  projecting `orderflow/prod/order-service` keys into `orderflow-prod`.
* `03-k3s-fake-provider-eso-lab.yaml` — Zero-cloud-bill ESO `v1`
  `SecretStore` (`provider.fake`) and `ExternalSecret` for local K3s.
* `04-sealed-secret-order-service.yaml` — `bitnami.com/v1alpha1`
  `SealedSecret` example paired with the migrated
  `https://bitnami.github.io/sealed-secrets` repository.
* `05-sops-config.yaml` — `.sops.yaml` encryption policy (`age` + KMS).
* `06-order-secret.enc.yaml` — SOPS-encrypted Secret artifact safe for Git.
