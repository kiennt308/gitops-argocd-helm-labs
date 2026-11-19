{{- define "orderflow-lib.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "orderflow-lib.fullname" . }}
  labels:
    {{- include "orderflow-lib.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.replicaCount }}
  revisionHistoryLimit: {{ .Values.revisionHistoryLimit | default 5 }}
  selector:
    matchLabels:
      {{- include "orderflow-lib.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      annotations:
        checksum/config: {{ printf "%v-%v" .Values.nginxMode (toYaml .Values.config) | sha256sum }}
        {{- with .Values.podAnnotations }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
      labels:
        {{- include "orderflow-lib.labels" . | nindent 8 }}
    spec:
      serviceAccountName: {{ include "orderflow-lib.serviceAccountName" . }}
      automountServiceAccountToken: {{ .Values.serviceAccount.automount | default false }}
      terminationGracePeriodSeconds: {{ .Values.terminationGracePeriodSeconds | default 30 }}
      securityContext:
        runAsNonRoot: {{ .Values.podSecurityContext.runAsNonRoot }}
        runAsUser: {{ .Values.podSecurityContext.runAsUser }}
        runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
        fsGroup: {{ .Values.podSecurityContext.fsGroup }}
        seccompProfile:
          type: RuntimeDefault
      containers:
        - name: {{ include "orderflow-lib.name" . }}
          image: {{ printf "%s:%s" .Values.image.repository .Values.image.tag | quote }}
          imagePullPolicy: {{ .Values.image.pullPolicy | default "IfNotPresent" }}
          {{- with .Values.command }}
          command:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.args }}
          args:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - ALL
          {{- if .Values.service.enabled }}
          ports:
            - name: http
              containerPort: {{ .Values.service.targetPort | default 8080 }}
              protocol: TCP
          {{- end }}
          {{- with .Values.env }}
          env:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.envFrom }}
          envFrom:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- if eq (.Values.probes.type | default "http") "http" }}
          livenessProbe:
            httpGet:
              path: {{ .Values.probes.path | default "/healthz" }}
              port: http
            initialDelaySeconds: 5
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: {{ .Values.probes.path | default "/healthz" }}
              port: http
            initialDelaySeconds: 3
            periodSeconds: 5
          {{- else if eq .Values.probes.type "exec" }}
          livenessProbe:
            exec:
              command:
                {{- toYaml .Values.probes.execCommand | nindent 16 }}
            initialDelaySeconds: 5
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
                {{- toYaml .Values.probes.execCommand | nindent 16 }}
            initialDelaySeconds: 3
            periodSeconds: 5
          {{- end }}
          {{- if gt (int (.Values.preStopSleepSeconds | default 5)) 0 }}
          lifecycle:
            preStop:
              exec:
                command:
                  - sh
                  - -c
                  - sleep {{ .Values.preStopSleepSeconds | default 5 }}
          {{- end }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          volumeMounts:
            - name: tmp
              mountPath: /tmp
            {{- if .Values.nginxMode }}
            - name: nginx-cache
              mountPath: /var/cache/nginx
            - name: nginx-run
              mountPath: /var/run
            - name: nginx-conf
              mountPath: /etc/nginx/nginx.conf
              subPath: nginx.conf
              readOnly: true
            {{- end }}
            {{- with .Values.extraVolumeMounts }}
            {{- toYaml . | nindent 12 }}
            {{- end }}
      volumes:
        - name: tmp
          emptyDir:
            sizeLimit: 64Mi
        {{- if .Values.nginxMode }}
        - name: nginx-cache
          emptyDir:
            sizeLimit: 32Mi
        - name: nginx-run
          emptyDir:
            sizeLimit: 16Mi
        - name: nginx-conf
          configMap:
            name: {{ include "orderflow-lib.fullname" . }}-config
        {{- end }}
        {{- with .Values.extraVolumes }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
{{- end }}
