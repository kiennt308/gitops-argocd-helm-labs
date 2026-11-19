{{- define "orderflow-lib.httproute" -}}
{{- if .Values.httpRoute.enabled }}
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ include "orderflow-lib.fullname" . }}
  labels:
    {{- include "orderflow-lib.labels" . | nindent 4 }}
spec:
  parentRefs:
    {{- range .Values.httpRoute.parentRefs }}
    - name: {{ .name }}
      {{- if .namespace }}
      namespace: {{ .namespace }}
      {{- end }}
      {{- if .sectionName }}
      sectionName: {{ .sectionName }}
      {{- end }}
    {{- end }}
  {{- with .Values.httpRoute.hostnames }}
  hostnames:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: {{ .Values.httpRoute.pathPrefix | default "/" }}
      backendRefs:
        - name: {{ include "orderflow-lib.fullname" . }}
          port: {{ .Values.service.port | default 8080 }}
{{- end }}
{{- end }}
