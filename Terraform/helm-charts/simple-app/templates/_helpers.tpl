{{/*
Return the full name of the chart
*/}}
{{- define "simple-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Return common labels
*/}}
{{- define "simple-app.labels" -}}
app.kubernetes.io/name: {{ include "simple-app.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Return selector labels
*/}}
{{- define "simple-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "simple-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Chart name
*/}}
{{- define "simple-app.name" -}}
{{- default .Chart.Name .Values.nameOverride }}
{{- end }}
