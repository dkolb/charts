# crafty-control-mc

A helm chart to deploy the crafty-control-mc to your kubernetes cluster.

![Version: 0.0.5](https://img.shields.io/badge/Version-0.0.5-informational?style=flat-square)

## Accessing inital password

You will want to run `kubectl get pod` to find the pod name and then
use `kubectl logs` to retrieve the stdout logs.

## Initial server setup

Depending on how you do your persistence, you may need to access the
pod to do the initial setup.  The crafty-controller docker container has
wget installed so you can use `kubectl exec` to get a shell on the pod and
layout your server directories and do initial downloads.

If you prefer you can create an empty file so long as it has a `.jar` extension
and use that as your first server to get past the initial config screen.

## Current Limitations

### Ingressing the Minecraft Ports

By their nature, Minecraft only exists in one controller pod. This chart
kinda makes some assumptions about how it's run, mainly that there is one
pod per namespace and likely that pod targets a very specific instance.

If you wish to use ClusterIP for the minecraft server services as opposed to
NodeIP, you will need to write your own TCP Ingress.  The most popular,
NGINX controller requires some work with setting up ConfigMaps and would make
the chart less agnostic.

Most cloud provider load balancers support TCP balancing and can provide
another way to get traffic into your cluster via a `LoadBalancer` service type
and annotations on the service.

## Values

### Annotations

All annotations values are simply key/value objects directly as if you
were writing the k8s manifest.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| fullnameOverride | string | `""` | Overrides places that utilize `release_name-crafty-control-mc` |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"dkolb/crafty-controller","tag":"latest"}` | Standard image chart vaule with `repository`, `pullPolicy`, and `tag` keys. |
| imagePullSecrets | list | `[]` | Array of secret names to use for conatiner registry auth. |
| minecrafts | list | `[{"name":"my-minecraft","service":{"annotations":{},"ports":[{"name":"gameserver","port":25565,"protocol":"TCP","targetPort":25565}],"type":"NodePort"}}]` | Populate this array with information on each minecraft server. |
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
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Refer to https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| webui.ingress.annotations | object | `{}` | Place to add annotations to the ingress. Reminder: This is where your cluster issuers and ingress classes go. Also you probably should annotate however you need to to indicate that HTTPS is the backend protocol |
| webui.ingress.certManager | bool | `false` | Add the certManager annotation to the ingress. |
| webui.ingress.enabled | bool | `false` | Generate an ingress for the Web UI. |
| webui.ingress.rules | list | `[{"host":"crafty-mc.local","paths":["/"]}]` | Abbreviated rules structure. |
| webui.ingress.tls | list | `[]` | Contains SSL configurations. ```yaml webui:   ingress:     tls:       - secretName: chart-example-tls         hosts:           - crafty-mc.local ``` |
| webui.service | object | `{"port":443,"type":"ClusterIP"}` | This configures the service specifically for the webui. |
| webui.service.port | int | `443` | Port to expose on service. |
| webui.service.type | string | `"ClusterIP"` | `LoadBalancer`, `ClusterIP`, `NodePort` |
