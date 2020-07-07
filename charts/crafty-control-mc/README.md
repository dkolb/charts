crafty-control-mc
=================
A helm chart to deploy the crafty-control-mc to your kubernetes cluster.

Current chart version is `0.0.1`

Source code can be found [here](https://github.com/dkolb/charts)



## Chart Values

### Annotations

All annotations values are simply key/value objects directly as if you
were writing the k8s manifest.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| fullnameOverride | string | `""` | Overrides places that utilize `release_name-crafty-control-mc` |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"dkolb/crafty-controller","tag":"latest"}` | Standard image chart vaule with `repository`, `pullPolicy`, and `tag` keys. |
| imagePullSecrets | list | `[]` | Array of secret names to use for conatiner registry auth. |
| ingress.annotations | object | `{}` | Place to add annotations to the ingress. Reminder: This is where your cluster issuers and ingress classes go, David. |
| ingress.certManager | bool | `true` |  |
| ingress.enabled | bool | `false` | Generate an ingress for the Web UI. |
| ingress.rules | list | `[{"host":"crafty-mc.local","paths":["/"]}]` | Abbreviated rules structure. |
| ingress.tls | list | `[]` | Contains SSL configurations. ```yaml ingress:   tls:     - secretName: chart-example-tls     hosts:       - crafty-mc.local ``` |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/ |
| persistence.backups.accessModes | list | `[]` | List of access modes, such as ReadWriteMany. |
| persistence.backups.annotations | object | `{}` | Set annotations directly on the PCV |
| persistence.backups.enabled | bool | `false` |  |
| persistence.backups.storageClassName | string | `""` | PCV storage class. |
| persistence.backups.storageSize | string | `"100Gi"` | Size to attempt to claim |
| persistence.db.accessModes | list | `[]` | List of access modes, such as ReadWriteMany. |
| persistence.db.annotations | object | `{}` | Set annotations directly on the PCV |
| persistence.db.enabled | bool | `false` | Enables a PersistentVolumeClaim for the database and mounts it to `/crafty_db` |
| persistence.db.storageClassName | string | `""` | PCV storage class. |
| persistence.db.storageSize | string | `"1Gi"` | Size to attempt to claim |
| persistence.servers.accessModes | list | `[]` | List of access modes, such as ReadWriteMany. |
| persistence.servers.annotations | object | `{}` | Set annotations directly on the PCV and mounts it to `/mincraft_servers` |
| persistence.servers.enabled | bool | `false` |  |
| persistence.servers.storageClassName | string | `""` | PCV storage class. |
| persistence.servers.storageSize | string | `"20Gi"` | Size to attempt to claim |
| podAnnotations | object | `{}` | An annotation object to apply to the pod. |
| podSecurityContext | object | `{}` | maps directly into `Deployment.spec.template.spec.securityContext` Reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#podsecuritycontext-v1-core |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Object containing limits and requests for the crafty-controller container. ```yaml resources:   limits:     cpu: 100m     memory: 128Mi   requests:     cpu: 100m     memory: 128Mi ``` |
| securityContext | object | `{}` | Container specific security context applied to the crafty-controller context. maps onto `Deployment.spec.template.spec.containers[*].securityContext` Reference: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#podsecuritycontext-v1-core |
| service.port | int | `443` | Port to expose on service. |
| service.type | string | `"ClusterIP"` | `LoadBalancer`, `ClusterIP`, `NodePort` |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
