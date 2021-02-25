# minecraft-backup

A Helm chart for Kubernetes

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square)

## Values

### Annotations

All annotations values are simply key/value objects directly as if you
were writing the k8s manifest.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| destination | string | `"destination:/backups"` | This is the argument passed to `destination`. See minecraft-backup repo for usage. |
| dryRun | bool | `false` | Set to true to pass the dry-run flag to the container and not actually copy/delete backups. |
| fullnameOverride | string | `""` | Overrides places that utilize `release_name-crafty-control-mc` |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/dkolb/minecraft-backup","tag":"edge"}` | Standard image chart value with `repository`, `pullPolicy`, and `tag` keys. |
| imagePullSecrets | list | `[]` | Array of secret names to use for conatiner registry auth. |
| nameOverride | string | `""` | Overrides places the chart name `crafty-control-mc` is used. |
| nodeSelector | object | `{}` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/ |
| podAnnotations | object | `{}` | An annotation object to apply to the pod. |
| podSecurityContext | object | `{}` | Maps directly into `Deployment.spec.template.spec.securityContext` Reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#podsecuritycontext-v1-core |
| rcloneSecretName | string | `"minecraft-backup-config"` | This secret is mounted to /root/.config/rclone/ in the container. It should contain your rclone.conf file at minimum. |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Object containing limits and requests for the crafty-controller container. ```yaml resources:   limits:     cpu: 100m     memory: 128Mi   requests:     cpu: 100m     memory: 128Mi ``` |
| restartPolicy | string | `"Never"` | The restart policy for the job container. Acceptable values are OnFailure or Never. Never is highly advised as a failed job should require intervention. |
| runs[0].backupInterval | string | `"daily"` | Passed in to the `backup-interval` argument (see minecraft-backup) |
| runs[0].schedule | string | `"0 5 * * *"` | maps directly onto [CronJob's `.spec.schedule`](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) |
| runs[1] | object | `{"backupInterval":"weekly","schedule":"0 8 * * 0"}` | . |
| runs[2] | object | `{"backupInterval":"monthly","schedule":"0 8 1 * *"}` | . |
| runs[3] | object | `{"backupInterval":"yearly","schedule":"0 8 1 1 *"}` | . |
| securityContext | object | `{}` | Container specific security context applied to the crafty-controller context. maps onto `Deployment.spec.template.spec.containers[*].securityContext` Reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#podsecuritycontext-v1-core |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| source | string | `"source:/mc-backup.zip"` | This is the argument passed to `source`. See minecraft-backup repo for usage. |
| tolerations | list | `[]` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| verbose | bool | `true` | Set to true to pass the verbose flag to the container. |
