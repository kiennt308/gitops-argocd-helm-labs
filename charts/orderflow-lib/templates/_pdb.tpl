{{- define "orderflow-lib.pdb" -}}
{{- if .Values.pdb.enabled }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ include "orderflow-lib.fullname" . }}
  labels:
    {{- include "orderflow-lib.labels" . | nindent 4 }}
spec:
  {{- if hasKey .Values.pdb "minAvailable" }}
  minAvailable: {{ .Values.pdb.minAvailable }}
  {{- else }}
  maxUnavailable: {{ .Values.pdb.maxUnavailable | default 1 }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "orderflow-lib.selectorLabels" . | nindent 6 }}
{{- end }}
{{- end }}
