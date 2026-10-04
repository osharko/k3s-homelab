# k3s-homelab

GitOps per il cluster k3s **homelab** (Proxmox VE + ZFS, 6 nodi).

- **ArgoCD** sincronizza questo repo (app-of-apps + ApplicationSet).
- **Secret**: i *valori* vivono in **1Password**; in questo repo solo la *config* (External Secrets Operator).
- **OpenTofu**: plumbing dei secret (bootstrap del token ESO), state mai committato.

> ⚠️ Repo **pubblico**: qui NON va nessun valore segreto, nessuno `.env`, nessuno state OpenTofu.
> Solo manifest, config provider-agnostica e ciphertext (se previsto).

## Bootstrap

1. `bootstrap/argocd/` — install ArgoCD in ns `argocd` + IngressRoute `argocd.osharko.lan`
2. `kubectl apply -f bootstrap/root-app.yaml` — app-of-apps
3. `clusters/homelab/apps.yaml` — ApplicationSet (auto-discovery di `apps/*` e `projects/*`)

## Layout

```
docs/              inventory + architettura
bootstrap/         install ArgoCD + root-app
clusters/homelab/  app-of-apps + ApplicationSet
infrastructure/    namespaces, traefik, pihole, postgres, cloudflared, ESO...
apps/              servizi (media/download/cloud)
projects/          progetti k3s (nuova cartella = nuovo progetto)
templates/project/ scaffold di un nuovo progetto
secrets/           ClusterSecretStore + ExternalSecret (config, no valori)
tofu/              OpenTofu (plumbing secret); state fuori repo
```

## Nuovo progetto k3s

```bash
cp -r templates/project projects/<nome>
# modifica namespace/deployment, poi:
git add projects/<nome> && git commit -m "add project <nome>" && git push
```

L'ApplicationSet rileva la cartella e crea l'Application; sincronizzi dalla UI ArgoCD.

## Documentazione

- `docs/inventory.md` — spec reale host/cluster/LXC/mount
- `docs/architecture.md` — architettura e decisioni
