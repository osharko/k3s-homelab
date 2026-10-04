# ExternalSecret (provider-agnostiche)

Una `ExternalSecret` per Secret applicativo, organizzate per namespace.

Esempio (da adattare) — mappa una chiave 1Password in un Secret k8s:

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: example
  namespace: example
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: onepassword      # ClusterSecretStore
    kind: ClusterSecretStore
  target:
    name: example          # nome del Secret k8s creato
  data:
    - secretKey: PASSWORD  # chiave nel Secret k8s
      remoteRef:
        key: example       # nome item 1Password
        property: password # campo dell'item
```

Convenzione: una cartella per namespace (`base/<ns>/`), un file per servizio.
