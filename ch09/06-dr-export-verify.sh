#!/usr/bin/env sh
# Copyright (c) 2026 Kien Nguyen (Apache-2.0)
# Control-plane backup and verification helper for Argo CD v3.6+

set -eu

BACKUP_DIR="${1:-./backups}"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
BACKUP_FILE="${BACKUP_DIR}/argocd-export-${TIMESTAMP}.yaml"

mkdir -p "${BACKUP_DIR}"

echo "Exporting Argo CD control plane resources to ${BACKUP_FILE}..."
kubectl -n argocd exec deploy/argocd-server -- \
  argocd admin export --namespace argocd > "${BACKUP_FILE}"

echo "Verifying exported YAML structure..."
grep -q "kind: Application" "${BACKUP_FILE}" || {
  echo "ERROR: Export missing Application objects" >&2
  exit 1
}

echo "Backup verified (${BACKUP_FILE}). Store encrypted off-cluster."
