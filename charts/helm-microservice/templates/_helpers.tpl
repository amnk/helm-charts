{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "helm-microservice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-microservice.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-microservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "helm-microservice.labels" -}}
helm.sh/chart: {{ include "helm-microservice.chart" . }}
{{ include "helm-microservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- range $key, $value := .Values.commonLabels }}
{{ $key }}: {{ $value }}
{{- end }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "helm-microservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm-microservice.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "helm-microservice.volumesWithClaims" -}}

  {{ $newList := list }}
  {{- range .Values.persistence.volumes }}
  {{- if not .existingClaimName }}
    {{ $newList = append $newList . }}
  {{- end }}
  {{- end }}

  {{ toJson $newList }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "helm-microservice.annotations" -}}
{{- range $key, $value := .Values.commonAnnotations }}
{{ $key }}: {{ $value }}
{{- end }}
{{- end -}}

