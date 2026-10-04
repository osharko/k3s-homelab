# infrastructure

Risorse di piattaforma del cluster, sincronizzate da ArgoCD.

Esempi previsti (migrazione incrementale dagli attuali manifest):

- `namespaces/`
- `traefik/` (già in kube-system via Helm k3s)
- `pihole/`, `cloudflared/`, `headscale/`, `homepage/`, `tailscale/`
- `postgres/`
- `external-secrets/` (ESO + ClusterSecretStore)

Convenzione: una cartella per componente con un `kustomization.yaml`.
