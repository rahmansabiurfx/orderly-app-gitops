{{- define "orderly-app.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "orderly-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "orderly-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orderly-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "orderly-app.labels" -}}
{{ include "orderly-app.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end -}}