# Chapter 7 Labs — Progressive Delivery with Argo Rollouts & Gateway API

Replaces retired `ingress-nginx` annotations with `Gateway API v1.6`
`HTTPRoute` traffic splitting driven by Argo Rollouts `v1.10.2` and
`rollouts-plugin-trafficrouter-gatewayapi v0.17.0`:

* `01-gateway-and-httproute.yaml` — `GatewayClass`, `Gateway`, and
  `HTTPRoute` routing `/api/v1/orders` across `order-service-stable`
  and `order-service-canary`.
* `02-rollouts-gateway-plugin-cm.yaml` — `argo-rollouts-config`
  ConfigMap loading `argoproj-labs/gatewayapi` `v0.17.0`.
* `03-order-service-rollout.yaml` — `Rollout` (`workloadRef` to
  `Deployment/order-service`) with `pingPong` services, canary weight
  steps, and inline `AnalysisTemplate` verification.
* `04-analysis-template-prometheus.yaml` — Prometheus 5xx error-rate and
  p95 latency metric gates.
* `05-rollout-services.yaml` — Stable and canary Services.
* `06-pingpong-rollout-example.yaml` — Zero-downtime `pingPong`
  (`pingService` / `pongService`) Rollout for long-lived connections.
