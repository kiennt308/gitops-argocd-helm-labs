{{- define "orderflow-lib.configmap" -}}
{{- if or .Values.config.enabled .Values.nginxMode }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "orderflow-lib.fullname" . }}-config
  labels:
    {{- include "orderflow-lib.labels" . | nindent 4 }}
data:
  {{- if .Values.nginxMode }}
  nginx.conf: |
    worker_processes 1;
    pid /tmp/nginx.pid;
    events {
      worker_connections 256;
    }
    http {
      client_body_temp_path /tmp/client_temp;
      proxy_temp_path /tmp/proxy_temp;
      fastcgi_temp_path /tmp/fastcgi_temp;
      uwsgi_temp_path /tmp/uwsgi_temp;
      scgi_temp_path /tmp/scgi_temp;
      access_log /dev/stdout;
      error_log /dev/stderr info;
      server {
        listen {{ .Values.service.targetPort | default 8080 }};
        location /healthz {
          default_type text/plain;
          return 200 "ok\n";
        }
        location / {
          default_type application/json;
          return 200 '{"service":"{{ include "orderflow-lib.name" . }}","status":"ok"}\n';
        }
      }
    }
  {{- end }}
  {{- with .Values.config.data }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}
{{- end }}
