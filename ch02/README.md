# Chapter 2 Labs — Production Helm 4 & Library Charts

Files in this directory drive the `orderflow-service` and `orderflow-lib`
charts under `../charts/`:

* `values-order-gateway.yaml` — Edge gateway configuration (`nginx:1.27-alpine`)
  with Gateway API `HTTPRoute` enabled on `/`.
* `values-order-service.yaml` — Core orders API configuration (`nginx:1.27-alpine`)
  with Gateway API `HTTPRoute` enabled on `/api/v1/orders`.
* `values-payment-worker.yaml` — Headless worker (`busybox:1.37`) using
  `exec` probes and `service.enabled: false`.
* `values-invalid-latest.yaml` — Negative test fixture intentionally
  violating `values.schema.json` (`image.tag: latest` and `runAsNonRoot: false`).

## Quick Validation (Helm v4.3.2)

```bash
docker run --rm -v "${PWD}/..:/work" -w /work/charts/orderflow-service \
  alpine/helm:latest dependency build

docker run --rm -v "${PWD}/..:/work" -w /work/charts/orderflow-service \
  alpine/helm:latest lint . --strict -f ../../ch02/values-order-service.yaml

docker run --rm -v "${PWD}/..:/work" -w /work/charts/orderflow-service \
  helmunittest/helm-unittest:latest .
```
