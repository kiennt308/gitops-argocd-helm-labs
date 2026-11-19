# Chapter 5 Labs — Source Hydrator, Sync Waves & Drift Discipline

* `01-application-source-hydrator.yaml` — Argo CD `v3.6`
  `spec.sourceHydrator` configuration honoring mandatory non-root
  `syncSource.path` (`v3.2+`) and Git Notes `refs/notes/hydrator.metadata`
  (`v3.3+`).
* `02-sync-waves-migration.yaml` — Live PSA-restricted `OrderFlow`
  database migration sequence (`ConfigMap` wave `-2`, `PreSync` Job
  wave `-1`, `Deployment`/`Service` wave `0`, `PostSync` smoke Job wave `1`).
* `03-ignore-differences-app.yaml` — `Application` demonstrating
  `ignoreDifferences` (`jqPathExpressions`) combined with
  `RespectIgnoreDifferences=true` and `ServerSideApply=true`.
