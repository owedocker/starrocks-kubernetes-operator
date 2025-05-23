{{/*
Common labels
*/}}
{{- define "starrockscluster.labels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
initpassword secret name
*/}}

{{- define "starrockscluster.initpassword.secret.name" -}}
{{ default (print (include "starrockscluster.name" .) "-credential") .Values.initPassword.passwordSecret }}
{{- end }}

{{/*
starrockscluster
*/}}

{{- define "starrockscluster.name" -}}
{{ default (default .Chart.Name .Values.nameOverride) .Values.starrocksCluster.name }}
{{- end }}

{{- define "starrockscluster.namespace" -}}
{{ default .Release.Namespace .Values.starrocksCluster.namespace }}
{{- end }}

{{- define "starrockscluster.fe.name" -}}
{{- print (include "starrockscluster.name" .) "-fe" }}
{{- end }}

{{- define "starrockscluster.cn.name" -}}
{{- print (include "starrockscluster.name" .) "-cn" }}
{{- end }}

{{- define "starrockscluster.be.name" -}}
{{- print (include "starrockscluster.name" .) "-be" }}
{{- end }}

{{- define "starrockscluster.be.configmap.name" -}}
{{- print (include "starrockscluster.be.name" .) "-cm" }}
{{- end }}

{{- define "starrockscluster.fe.configmap.name" -}}
{{- print (include "starrockscluster.fe.name" .) "-cm" }}
{{- end }}

{{- define "starrockscluster.cn.configmap.name" -}}
{{- print (include "starrockscluster.cn.name" .) "-cm" }}
{{- end }}

{{- define "starrockscluster.fe.config" -}}
fe.conf: |
{{- if and .Values.starrocksFESpec.configyaml (kindIs "map" .Values.starrocksFESpec.configyaml) }}
  {{- range $key, $value := .Values.starrocksFESpec.configyaml }}
    {{ $key }} = {{ $value }}
  {{- end }}
{{- else if .Values.starrocksFESpec.configyaml }}
  {{ fail "configyaml must be a map" }}
{{- else }}
  {{- .Values.starrocksFESpec.config | nindent 2 }}
{{- end }}
{{- end }}

{{- define "starrockscluster.cn.config" -}}
cn.conf: |
{{- if and .Values.starrocksCnSpec.configyaml (kindIs "map" .Values.starrocksCnSpec.configyaml) }}
  {{- range $key, $value := .Values.starrocksCnSpec.configyaml }}
    {{ $key }} = {{ $value }}
  {{- end }}
{{- else if .Values.starrocksCnSpec.configyaml }}
  {{ fail "configyaml must be a map" }}
{{- else }}
  {{- .Values.starrocksCnSpec.config | nindent 2 }}
{{- end }}
{{- end }}

{{- define "starrockscluster.be.config" -}}
be.conf: |
{{- if and .Values.starrocksBeSpec.configyaml (kindIs "map" .Values.starrocksBeSpec.configyaml) }}
  {{- range $key, $value := .Values.starrocksBeSpec.configyaml }}
    {{ $key }} = {{ $value }}
  {{- end }}
{{- else if .Values.starrocksBeSpec.configyaml }}
  {{ fail "configyaml must be a map" }}
{{- else }}
  {{- .Values.starrocksBeSpec.config | nindent 2 }}
{{- end }}
{{- end }}

{{- define "starrockscluster.fe.meta.suffix" -}}
{{- print "-meta" }}
{{- end }}

{{- define "starrockscluster.fe.meta.path" -}}
{{- if .Values.starrocksFESpec.storageSpec.storageMountPath }}
{{- print .Values.starrocksFESpec.storageSpec.storageMountPath }}
{{- else }}
{{- print "/opt/starrocks/fe/meta" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.fe.log.suffix" -}}
{{- print "-log" }}
{{- end }}

{{- define "starrockscluster.fe.log.path" -}}
{{- if .Values.starrocksFESpec.storageSpec.logMountPath }}
{{- print .Values.starrocksFESpec.storageSpec.logMountPath }}
{{- else }}
{{- print "/opt/starrocks/fe/log" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.be.data.suffix" -}}
{{- print "-data" }}
{{- end }}

{{- define "starrockscluster.be.data.path" -}}
{{- if .Values.starrocksBeSpec.storageSpec.storageMountPath }}
{{- print .Values.starrocksBeSpec.storageSpec.storageMountPath }}
{{- else }}
{{- print "/opt/starrocks/be/storage" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.be.log.suffix" -}}
{{- print "-log" }}
{{- end }}

{{- define "starrockscluster.be.log.path" -}}
{{- if .Values.starrocksBeSpec.storageSpec.logMountPath }}
{{- print .Values.starrocksBeSpec.storageSpec.logMountPath }}
{{- else }}
{{- print "/opt/starrocks/be/log" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.be.spill.suffix" -}}
{{- print "-spill" }}
{{- end }}

{{- define "starrockscluster.be.spill.path" -}}
{{- if .Values.starrocksBeSpec.storageSpec.spillMountPath }}
{{- print .Values.starrocksBeSpec.storageSpec.spillMountPath }}
{{- else }}
{{- print "/opt/starrocks/be/spill" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.cn.data.suffix" -}}
{{- print "-data" }}
{{- end }}

{{- define "starrockscluster.cn.data.path" -}}
{{- if .Values.starrocksCnSpec.storageSpec.storageMountPath }}
{{- print .Values.starrocksCnSpec.storageSpec.storageMountPath }}
{{- else }}
{{- print "/opt/starrocks/cn/storage" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.cn.log.suffix" -}}
{{- print "-log" }}
{{- end }}

{{- define "starrockscluster.cn.log.path" -}}
{{- if .Values.starrocksCnSpec.storageSpec.logMountPath }}
{{- print .Values.starrocksCnSpec.storageSpec.logMountPath }}
{{- else }}
{{- print "/opt/starrocks/cn/log" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.cn.spill.suffix" -}}
{{- print "-spill" }}
{{- end }}

{{- define "starrockscluster.cn.spill.path" -}}
{{- if .Values.starrocksCnSpec.storageSpec.spillMountPath }}
{{- print .Values.starrocksCnSpec.storageSpec.spillMountPath }}
{{- else }}
{{- print "/opt/starrocks/cn/spill" }}
{{- end }}
{{- end }}

{{- define "starrockscluster.entrypoint.script.name" -}}
{{- print "entrypoint.sh" }}
{{- end }}

{{- define "starrockscluster.entrypoint.mount.path" -}}
{{- print "/etc/starrocks" }}
{{- end }}

{{- define "starrockscluster.fe.entrypoint.script.configmap.name" -}}
{{- print (include "starrockscluster.name" .) "-fe-entrypoint-script" }}
{{- end }}

{{- define "starrockscluster.be.entrypoint.script.configmap.name" -}}
{{- print (include "starrockscluster.name" .) "-be-entrypoint-script" }}
{{- end }}

{{- define "starrockscluster.cn.entrypoint.script.configmap.name" -}}
{{- print (include "starrockscluster.name" .) "-cn-entrypoint-script" }}
{{- end }}

{{/*
Define a function to handle resource limits for fe
*/}}
{{- define "starrockscluster.fe.resources" -}}
requests:
  {{- toYaml .Values.starrocksFESpec.resources.requests | nindent 2 }}
limits:
{{- range $key, $value := .Values.starrocksFESpec.resources.limits }}
  {{- if ne (toString $value) "unlimited" }}
  {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Define a function to handle resource limits for be
*/}}
{{- define "starrockscluster.be.resources" -}}
requests:
  {{- toYaml .Values.starrocksBeSpec.resources.requests | nindent 2 }}
limits:
{{- range $key, $value := .Values.starrocksBeSpec.resources.limits }}
  {{- if ne (toString $value) "unlimited" }}
  {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Define a function to handle resource limits for cn
*/}}
{{- define "starrockscluster.cn.resources" -}}
requests:
  {{- toYaml .Values.starrocksCnSpec.resources.requests | nindent 2 }}
limits:
{{- range $key, $value := .Values.starrocksCnSpec.resources.limits }}
  {{- if ne (toString $value) "unlimited" }}
  {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
starrockscluster.fe.config.hash is used to calculate the hash value of the fe.conf, and due to the length limit, only
the first 8 digits are taken, which will be used as the annotations for pods.
*/}}
{{- define "starrockscluster.fe.config.hash" }}
  {{- if and .Values.starrocksFESpec.configyaml (kindIs "map" .Values.starrocksFESpec.configyaml) }}
    {{- $hash := toJson .Values.starrocksFESpec.configyaml | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else if .Values.starrocksFESpec.configyaml }}
    {{ fail "configyaml must be a map" }}
  {{- else if .Values.starrocksFESpec.config }}
    {{- $hash := toJson .Values.starrocksFESpec.config | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else }}
    {{- printf "no-config" }}
  {{- end }}
{{- end }}


{{/*
starrockscluster.be.config.hash is used to calculate the hash value of the be.conf, and due to the length limit, only
the first 8 digits are taken, which will be used as the annotations for pods.
*/}}
{{- define "starrockscluster.be.config.hash" }}
  {{- if and .Values.starrocksBeSpec.configyaml (kindIs "map" .Values.starrocksBeSpec.configyaml) }}
    {{- $hash := toJson .Values.starrocksBeSpec.configyaml | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else if .Values.starrocksBeSpec.configyaml }}
    {{ fail "configyaml must be a map" }}
  {{- else if .Values.starrocksBeSpec.config }}
    {{- $hash := toJson .Values.starrocksBeSpec.config | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else }}
    {{- printf "no-config" }}
  {{- end }}
{{- end }}

{{/*
starrockscluster.cn.config.hash is used to calculate the hash value of the cn.conf, and due to the length limit, only
the first 8 digits are taken, which will be used as the annotations for pods.
*/}}
{{- define "starrockscluster.cn.config.hash" }}
  {{- if and .Values.starrocksCnSpec.configyaml (kindIs "map" .Values.starrocksCnSpec.configyaml) }}
    {{- $hash := toJson .Values.starrocksCnSpec.configyaml | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else if .Values.starrocksCnSpec.configyaml }}
    {{ fail "configyaml must be a map" }}
  {{- else if .Values.starrocksCnSpec.config }}
    {{- $hash := toJson .Values.starrocksCnSpec.config | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else }}
    {{- printf "no-config" }}
  {{- end }}
{{- end }}

{{- define "starrockscluster.fe.query.port" -}}
{{- $config := index .Values.starrocksFESpec.config  -}}
{{- $configMap := dict -}}
{{- range $line := splitList "\n" $config -}}
{{- $pair := splitList "=" $line -}}
{{- if eq (len $pair) 2 -}}
{{- $_ := set $configMap (trim (index $pair 0)) (trim (index $pair 1)) -}}
{{- end -}}
{{- end -}}
{{- if (index $configMap "query_port") -}}
{{- print (index $configMap "query_port") }}
{{- end }}
{{- end }}

{{- define "starrockscluster.fe.entrypoint.script.hash" }}
  {{- if .Values.starrocksFESpec.entrypoint }}
    {{- $hash := toJson .Values.starrocksFESpec.entrypoint.script | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else }}
    {{- printf "no-config" }}
  {{- end }}
{{- end }}

{{- define "starrockscluster.be.entrypoint.script.hash" }}
  {{- if .Values.starrocksBeSpec.entrypoint }}
    {{- $hash := toJson .Values.starrocksBeSpec.entrypoint.script | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else }}
    {{- printf "no-config" }}
  {{- end }}
{{- end }}

{{- define "starrockscluster.cn.entrypoint.script.hash" }}
  {{- if .Values.starrocksCnSpec.entrypoint }}
    {{- $hash := toJson .Values.starrocksCnSpec.entrypoint.script | sha256sum | trunc 8 }}
    {{- printf "%s" $hash }}
  {{- else }}
    {{- printf "no-config" }}
  {{- end }}
{{- end }}

{{- define "starrockscluster.fe.http.port" -}}
{{- $config := index .Values.starrocksFESpec.config  -}}
{{- $configMap := dict -}}
{{- range $line := splitList "\n" $config -}}
{{- $pair := splitList "=" $line -}}
{{- if eq (len $pair) 2 -}}
{{- $_ := set $configMap (trim (index $pair 0)) (trim (index $pair 1)) -}}
{{- end -}}
{{- end -}}
{{- if (index $configMap "http_port") -}}
{{- print (index $configMap "http_port") }}
{{- end }}
{{- end }}

{{- define "starrockscluster.be.webserver.port" -}}
{{- include "starrockscluster.webserver.port" .Values.starrocksBeSpec }}
{{- end }}

{{- define "starrockscluster.cn.webserver.port" -}}
{{- include "starrockscluster.webserver.port" .Values.starrocksCnSpec }}
{{- end }}

{{- define "starrockscluster.webserver.port" -}}
{{- $config := index .config  -}}
{{- $configMap := dict -}}
{{- range $line := splitList "\n" $config -}}
{{- $pair := splitList "=" $line -}}
{{- if eq (len $pair) 2 -}}
{{- $_ := set $configMap (trim (index $pair 0)) (trim (index $pair 1)) -}}
{{- end -}}
{{- end -}}
{{- if (index $configMap "webserver_port") -}}
{{- print (index $configMap "webserver_port") }}
{{- end }}
{{- end }}

{{/*
Get the value of the schedulerName field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.schedulerName" -}}
{{- if .Values.starrocksFESpec.schedulerName -}}
{{- .Values.starrocksFESpec.schedulerName -}}
{{- else if .Values.starrocksCluster.componentValues.schedulerName -}}
{{- .Values.starrocksCluster.componentValues.schedulerName -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the schedulerName field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.schedulerName" -}}
{{- if .Values.starrocksBeSpec.schedulerName -}}
{{- .Values.starrocksBeSpec.schedulerName -}}
{{- else if .Values.starrocksCluster.componentValues.schedulerName -}}
{{- .Values.starrocksCluster.componentValues.schedulerName -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the schedulerName field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.schedulerName" -}}
{{- if .Values.starrocksCnSpec.schedulerName -}}
{{- .Values.starrocksCnSpec.schedulerName -}}
{{- else if .Values.starrocksCluster.componentValues.schedulerName -}}
{{- .Values.starrocksCluster.componentValues.schedulerName -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the serviceAccount field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.serviceAccount" -}}
{{- if .Values.starrocksFESpec.serviceAccount -}}
{{- .Values.starrocksFESpec.serviceAccount -}}
{{- else if .Values.starrocksCluster.componentValues.serviceAccount -}}
{{- .Values.starrocksCluster.componentValues.serviceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the serviceAccount field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.serviceAccount" -}}
{{- if .Values.starrocksBeSpec.serviceAccount -}}
{{- .Values.starrocksBeSpec.serviceAccount -}}
{{- else if .Values.starrocksCluster.componentValues.serviceAccount -}}
{{- .Values.starrocksCluster.componentValues.serviceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the serviceAccount field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.serviceAccount" -}}
{{- if .Values.starrocksCnSpec.serviceAccount -}}
{{- .Values.starrocksCnSpec.serviceAccount -}}
{{- else if .Values.starrocksCluster.componentValues.serviceAccount -}}
{{- .Values.starrocksCluster.componentValues.serviceAccount -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the imagePullSecrets field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.imagePullSecrets" -}}
{{- if .Values.starrocksFESpec.imagePullSecrets -}}
{{- toYaml .Values.starrocksFESpec.imagePullSecrets -}}
{{- else if .Values.starrocksCluster.componentValues.imagePullSecrets -}}
{{- toYaml .Values.starrocksCluster.componentValues.imagePullSecrets -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the imagePullSecrets field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.imagePullSecrets" -}}
{{- if .Values.starrocksBeSpec.imagePullSecrets -}}
{{- toYaml .Values.starrocksBeSpec.imagePullSecrets -}}
{{- else if .Values.starrocksCluster.componentValues.imagePullSecrets -}}
{{- toYaml .Values.starrocksCluster.componentValues.imagePullSecrets -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the imagePullSecrets field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.imagePullSecrets" -}}
{{- if .Values.starrocksCnSpec.imagePullSecrets -}}
{{- toYaml .Values.starrocksCnSpec.imagePullSecrets -}}
{{- else if .Values.starrocksCluster.componentValues.imagePullSecrets -}}
{{- toYaml .Values.starrocksCluster.componentValues.imagePullSecrets -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the tolerations field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.tolerations" -}}
{{- if .Values.starrocksFESpec.tolerations -}}
{{- toYaml .Values.starrocksFESpec.tolerations -}}
{{- else if .Values.starrocksCluster.componentValues.tolerations -}}
{{- toYaml .Values.starrocksCluster.componentValues.tolerations -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the tolerations field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.tolerations" -}}
{{- if .Values.starrocksBeSpec.tolerations -}}
{{- toYaml .Values.starrocksBeSpec.tolerations -}}
{{- else if .Values.starrocksCluster.componentValues.tolerations -}}
{{- toYaml .Values.starrocksCluster.componentValues.tolerations -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the tolerations field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.tolerations" -}}
{{- if .Values.starrocksCnSpec.tolerations -}}
{{- toYaml .Values.starrocksCnSpec.tolerations -}}
{{- else if .Values.starrocksCluster.componentValues.tolerations -}}
{{- toYaml .Values.starrocksCluster.componentValues.tolerations -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the nodeSelector field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.nodeSelector" -}}
{{- if .Values.starrocksFESpec.nodeSelector -}}
{{- toYaml .Values.starrocksFESpec.nodeSelector -}}
{{- else if .Values.starrocksCluster.componentValues.nodeSelector -}}
{{- toYaml .Values.starrocksCluster.componentValues.nodeSelector -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the nodeSelector field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.nodeSelector" -}}
{{- if .Values.starrocksBeSpec.nodeSelector -}}
{{- toYaml .Values.starrocksBeSpec.nodeSelector -}}
{{- else if .Values.starrocksCluster.componentValues.nodeSelector -}}
{{- toYaml .Values.starrocksCluster.componentValues.nodeSelector -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the nodeSelector field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.nodeSelector" -}}
{{- if .Values.starrocksCnSpec.nodeSelector -}}
{{- toYaml .Values.starrocksCnSpec.nodeSelector -}}
{{- else if .Values.starrocksCluster.componentValues.nodeSelector -}}
{{- toYaml .Values.starrocksCluster.componentValues.nodeSelector -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the affinity field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.affinity" -}}
{{- if .Values.starrocksFESpec.affinity -}}
{{- toYaml .Values.starrocksFESpec.affinity -}}
{{- else if .Values.starrocksCluster.componentValues.affinity -}}
{{- toYaml .Values.starrocksCluster.componentValues.affinity -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the affinity field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.affinity" -}}
{{- if .Values.starrocksBeSpec.affinity -}}
{{- toYaml .Values.starrocksBeSpec.affinity -}}
{{- else if .Values.starrocksCluster.componentValues.affinity -}}
{{- toYaml .Values.starrocksCluster.componentValues.affinity -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the affinity field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.affinity" -}}
{{- if .Values.starrocksCnSpec.affinity -}}
{{- toYaml .Values.starrocksCnSpec.affinity -}}
{{- else if .Values.starrocksCluster.componentValues.affinity -}}
{{- toYaml .Values.starrocksCluster.componentValues.affinity -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the topologySpreadConstraints field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.topologySpreadConstraints" -}}
{{- if .Values.starrocksFESpec.topologySpreadConstraints -}}
{{- toYaml .Values.starrocksFESpec.topologySpreadConstraints -}}
{{- else if .Values.starrocksCluster.componentValues.topologySpreadConstraints -}}
{{- toYaml .Values.starrocksCluster.componentValues.topologySpreadConstraints -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the topologySpreadConstraints field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.topologySpreadConstraints" -}}
{{- if .Values.starrocksBeSpec.topologySpreadConstraints -}}
{{- toYaml .Values.starrocksBeSpec.topologySpreadConstraints -}}
{{- else if .Values.starrocksCluster.componentValues.topologySpreadConstraints -}}
{{- toYaml .Values.starrocksCluster.componentValues.topologySpreadConstraints -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the topologySpreadConstraints field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.topologySpreadConstraints" -}}
{{- if .Values.starrocksCnSpec.topologySpreadConstraints -}}
{{- toYaml .Values.starrocksCnSpec.topologySpreadConstraints -}}
{{- else if .Values.starrocksCluster.componentValues.topologySpreadConstraints -}}
{{- toYaml .Values.starrocksCluster.componentValues.topologySpreadConstraints -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of the runAsNonRoot field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.runAsNonRoot" -}}
{{- .Values.starrocksFESpec.runAsNonRoot | default .Values.starrocksCluster.componentValues.runAsNonRoot }}
{{- end }}

{{/*
Get the value of the runAsNonRoot field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.runAsNonRoot" -}}
{{- .Values.starrocksBeSpec.runAsNonRoot | default .Values.starrocksCluster.componentValues.runAsNonRoot }}
{{- end }}

{{/*
Get the value of the runAsNonRoot field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.runAsNonRoot" -}}
{{- .Values.starrocksCnSpec.runAsNonRoot | default .Values.starrocksCluster.componentValues.runAsNonRoot }}
{{- end }}

{{/*
Get the value of hostAliases field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.hostAliases" -}}
{{- if .Values.starrocksFESpec.hostAliases -}}
{{- toYaml .Values.starrocksFESpec.hostAliases -}}
{{- else if .Values.starrocksCluster.componentValues.hostAliases -}}
{{- toYaml .Values.starrocksCluster.componentValues.hostAliases -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of hostAliases field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.hostAliases" -}}
{{- if .Values.starrocksBeSpec.hostAliases -}}
{{- toYaml .Values.starrocksBeSpec.hostAliases -}}
{{- else if .Values.starrocksCluster.componentValues.hostAliases -}}
{{- toYaml .Values.starrocksCluster.componentValues.hostAliases -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of hostAliases field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.hostAliases" -}}
{{- if .Values.starrocksCnSpec.hostAliases -}}
{{- toYaml .Values.starrocksCnSpec.hostAliases -}}
{{- else if .Values.starrocksCluster.componentValues.hostAliases -}}
{{- toYaml .Values.starrocksCluster.componentValues.hostAliases -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of tag field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.image.tag" -}}
{{- if .Values.starrocksFESpec.image.tag -}}
{{- .Values.starrocksFESpec.image.tag -}}
{{- else if .Values.starrocksCluster.componentValues.image.tag -}}
{{- .Values.starrocksCluster.componentValues.image.tag -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of tag field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.image.tag" -}}
{{- if .Values.starrocksBeSpec.image.tag -}}
{{- .Values.starrocksBeSpec.image.tag -}}
{{- else if .Values.starrocksCluster.componentValues.image.tag -}}
{{- .Values.starrocksCluster.componentValues.image.tag -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of tag field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.image.tag" -}}
{{- if .Values.starrocksCnSpec.image.tag -}}
{{- .Values.starrocksCnSpec.image.tag -}}
{{- else if .Values.starrocksCluster.componentValues.image.tag -}}
{{- .Values.starrocksCluster.componentValues.image.tag -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of podLabels field in the starrocksFESpec
*/}}
{{- define "starrockscluster.fe.podLabels" -}}
{{- if .Values.starrocksFESpec.podLabels -}}
{{- toYaml .Values.starrocksFESpec.podLabels -}}
{{- else if .Values.starrocksCluster.componentValues.podLabels -}}
{{- toYaml .Values.starrocksCluster.componentValues.podLabels -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of podLabels field in the starrocksBeSpec
*/}}
{{- define "starrockscluster.be.podLabels" -}}
{{- if .Values.starrocksBeSpec.podLabels -}}
{{- toYaml .Values.starrocksBeSpec.podLabels -}}
{{- else if .Values.starrocksCluster.componentValues.podLabels -}}
{{- toYaml .Values.starrocksCluster.componentValues.podLabels -}}
{{- end -}}
{{- end -}}

{{/*
Get the value of podLabels field in the starrocksCnSpec
*/}}
{{- define "starrockscluster.cn.podLabels" -}}
{{- if .Values.starrocksCnSpec.podLabels -}}
{{- toYaml .Values.starrocksCnSpec.podLabels -}}
{{- else if .Values.starrocksCluster.componentValues.podLabels -}}
{{- toYaml .Values.starrocksCluster.componentValues.podLabels -}}
{{- end -}}
{{- end -}}
