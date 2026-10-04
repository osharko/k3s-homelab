# infrastructure

Risorse di piattaforma — **una cartella per componente** (`infrastructure/<name>/`),
auto-scoperte dal git directory generator (`infrastructure/*`).

- `infrastructure/external-secrets/` — ESO (Fase 2)
- `infrastructure/pihole/`, `infrastructure/cloudflared/`, `infrastructure/homepage/`,
  `infrastructure/headscale/`, `infrastructure/tailscale/`
- `infrastructure/postgres/`
- `infrastructure/traefik/` (già Helm di k3s: valutare se adottarlo)

Convenzione: `kustomization.yaml` per componente.
